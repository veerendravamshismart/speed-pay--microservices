package rest

import (
	"context"
	"database/sql"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"

	db "github.com/speedpay/internal/db/retailer"
)

// RestServer represents the REST API server.
type RestServer struct {
	Srv         *gin.Engine
	Log         *zap.SugaredLogger
	Db          *db.Queries
	RedisClient *redis.Client
}

// NewServer initializes a new RestServer instance.
func NewServer(db *db.Queries, log *zap.SugaredLogger, redisClient *redis.Client) *RestServer {
	srv := gin.Default()
	return &RestServer{
		Srv:         srv,
		Log:         log,
		Db:          db,
		RedisClient: redisClient,
	}
}

// RegisterRoutes registers all routes and starts the Gin server.
func (r *RestServer) RegisterRoutes(router *gin.Engine) {
	router.GET("v1/retailers", r.getAllRetailers)
	router.GET("v1/retailers/:?channel_id", r.getRetailerByID)

	router.GET("v1/retailers-by-sales-manager/:channel_id", r.getSalesManagersByChannelID)
}

func (r *RestServer) getAllRetailers(c *gin.Context) {
	cacheKey := "all_retailers"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for retailers")
		var retailers []db.TblChannel
		json.Unmarshal([]byte(cachedData), &retailers)
		c.JSON(http.StatusOK, retailers)
		return
	}

	r.Log.Infof("Cache miss for retailers")
	retailers, err := r.Db.GetAllRetailers(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch retailers: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch retailers"})
		return
	}

	retailersJSON, _ := json.Marshal(retailers)
	r.RedisClient.Set(context.Background(), cacheKey, retailersJSON, 0)
	c.JSON(http.StatusOK, retailers)
}

func (r *RestServer) getRetailerByID(c *gin.Context) {
	channelID := c.Param("channel_id")
	cacheKey := "retailer_" + channelID

	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for retailer %s", channelID)
		var retailer db.TblChannel
		json.Unmarshal([]byte(cachedData), &retailer)
		c.JSON(http.StatusOK, retailer)
		return
	}
	// Convert channelID to int
	operatorIdInt, err := strconv.Atoi(channelID)
	if err != nil {
		r.Log.Errorf("Invalid operatorId: %v", err)
		c.JSON(400, gin.H{"error": "Invalid operatorId"})
		return
	}
	nullOperator := sql.NullInt32{
		Int32: int32(operatorIdInt),
	}

	r.Log.Infof("Cache miss for retailer %s", channelID)
	retailer, err := r.Db.GetRetailerByID(context.Background(), nullOperator.Int32)
	if err != nil {
		r.Log.Errorf("Failed to fetch retailer: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch retailer"})
		return
	}

	retailerJSON, _ := json.Marshal(retailer)
	r.RedisClient.Set(context.Background(), cacheKey, retailerJSON, 0)
	c.JSON(http.StatusOK, retailer)
}

func (r *RestServer) getSalesManagersByChannelID(c *gin.Context) {
	channelID := c.Param("channel_id")
	cacheKey := "sales_managers_" + channelID

	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for sales managers %s", channelID)
		var salesManagers []db.TblChannel
		json.Unmarshal([]byte(cachedData), &salesManagers)
		c.JSON(http.StatusOK, salesManagers)
		return
	}

	r.Log.Infof("Cache miss for sales managers %s", channelID)
	channelIDInt, err := strconv.Atoi(channelID)
	if err != nil {
		r.Log.Errorf("Invalid channel ID: %v", err)
		c.JSON(400, gin.H{"error": "Invalid channel ID"})
		return
	}
	nullChannelID := sql.NullInt32{
		Int32: int32(channelIDInt),
		Valid: true, // Valid = true since we have a valid ID
	}

	salesManagers, err := r.Db.GetSalesManagersByChannelID(context.Background(), nullChannelID)
	if err != nil {
		r.Log.Errorf("Failed to fetch sales managers: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch sales managers"})
		return
	}

	salesManagersJSON, _ := json.Marshal(salesManagers)
	r.RedisClient.Set(context.Background(), cacheKey, salesManagersJSON, 0)
	c.JSON(http.StatusOK, salesManagers)
}
