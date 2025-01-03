package rest

import (
	"context"
	"encoding/json"
	"github.com/speedpay/cmd/masterdata-service/pkg/db"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"
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

// Start registers all routes and starts the Gin server.
func (r *RestServer) RegisterRoutes(router *gin.Engine) {
    router.GET("/regions", r.getRegions)
    router.GET("/currencies", r.getCurrencies)
    router.GET("/areas", r.getAreas)
    router.GET("/countries/:id", r.getCountryByID)
    router.POST("/countries", r.createCountry)
}



// getRegions handles GET /regions.
func (r *RestServer) getRegions(c *gin.Context) {
	cacheKey := "regions"
	cachedRegions, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for regions")
		var regions []db.Region
		json.Unmarshal([]byte(cachedRegions), &regions)
		c.JSON(200, regions)
		return
	}

	r.Log.Infof("Cache miss for regions")
	regions, err := r.Db.GetAllRegions(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch regions: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch regions"})
		return
	}

	regionsJSON, _ := json.Marshal(regions)
	r.RedisClient.Set(context.Background(), cacheKey, regionsJSON, 0)
	c.JSON(200, regions)
}

// getCurrencies handles GET /currencies.
func (r *RestServer) getCurrencies(c *gin.Context) {
	cacheKey := "currencies"
	cachedCurrencies, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for currencies")
		var currencies []db.Currency
		json.Unmarshal([]byte(cachedCurrencies), &currencies)
		c.JSON(200, currencies)
		return
	}

	r.Log.Infof("Cache miss for currencies")
	currencies, err := r.Db.GetAllCurrencies(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch currencies: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch currencies"})
		return
	}

	currenciesJSON, _ := json.Marshal(currencies)
	r.RedisClient.Set(context.Background(), cacheKey, currenciesJSON, 0)
	c.JSON(200, currencies)
}

// getAreas handles GET /areas.
func (r *RestServer) getAreas(c *gin.Context) {
	cacheKey := "areas"
	cachedAreas, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for areas")
		var areas []db.Area
		json.Unmarshal([]byte(cachedAreas), &areas)
		c.JSON(200, areas)
		return
	}

	r.Log.Infof("Cache miss for areas")
	areas, err := r.Db.GetAllAreas(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch areas: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch areas"})
		return
	}

	areasJSON, _ := json.Marshal(areas)
	r.RedisClient.Set(context.Background(), cacheKey, areasJSON, 0)
	c.JSON(200, areas)
}

// getCountryByID handles GET /countries/:id.
func (r *RestServer) getCountryByID(c *gin.Context) {
	id := c.Param("id")
	cacheKey := "country_" + id

	cachedCountry, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for country ID %s", id)
		var country db.Country
		json.Unmarshal([]byte(cachedCountry), &country)
		c.JSON(200, country)
		return
	}

	r.Log.Infof("Cache miss for country ID %s", id)
	countryID, err := strconv.Atoi(id)
	if err != nil {
		r.Log.Errorf("Invalid country ID: %v", err)
		c.JSON(400, gin.H{"error": "Invalid country ID"})
		return
	}

	country, err := r.Db.GetCountryByID(context.Background(), int32(countryID))
	if err != nil {
		r.Log.Errorf("Failed to fetch country: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch country"})
		return
	}

	countryJSON, _ := json.Marshal(country)
	r.RedisClient.Set(context.Background(), cacheKey, countryJSON, 0)
	c.JSON(200, country)
}

// createCountry handles POST /countries.
func (r *RestServer) createCountry(c *gin.Context) {
	var req struct {
		AreaID int32 `json:"area_id"`
	}

	if err := c.BindJSON(&req); err != nil {
		r.Log.Errorf("Invalid request body: %v", err)
		c.JSON(400, gin.H{"error": "Invalid request body"})
		return
	}

	err := r.Db.CreateCountry(context.Background(), req.AreaID)
	if err != nil {
		r.Log.Errorf("Failed to create country: %v", err)
		c.JSON(500, gin.H{"error": "Failed to create country"})
		return
	}

	c.JSON(201, gin.H{"message": "Country created successfully"})
}
