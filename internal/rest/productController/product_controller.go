package rest

import (
	"context"
	"database/sql"
	"encoding/json"
	"strconv"

	db "github.com/speedpay/internal/db/productcontroller"

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

// RegisterRoutes registers all routes and starts the Gin server.
func (r *RestServer) RegisterRoutes(router *gin.Engine) {
	router.GET("v1/countries", r.getAllCountries)

	router.GET("/operators", r.getAllOperators)
	router.GET("/operators/:productId", r.getOperatorProducts)
	router.GET("/products/:product_image", r.getProductImage)
}

func (r *RestServer) getAllCountries(c *gin.Context) {
	cacheKey := "countries"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for countries")
		var countries []db.TblCountry
		json.Unmarshal([]byte(cachedData), &countries)
		c.JSON(200, countries)
		return
	}

	r.Log.Infof("Cache miss for countries")
	countries, err := r.Db.GetCountries(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch countries: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch countries"})
		return
	}

	countriesJSON, _ := json.Marshal(countries)
	r.RedisClient.Set(context.Background(), cacheKey, countriesJSON, 0)
	c.JSON(200, countries)
}

// getAllOperators handles GET /operators.
func (r *RestServer) getAllOperators(c *gin.Context) {
	cacheKey := "operators"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for operators")
		var operators []db.TblOperator
		json.Unmarshal([]byte(cachedData), &operators)
		c.JSON(200, operators)
		return
	}

	r.Log.Infof("Cache miss for operators")
	operators, err := r.Db.GetOperators(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch operators: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch operators"})
		return
	}

	operatorsJSON, _ := json.Marshal(operators)
	r.RedisClient.Set(context.Background(), cacheKey, operatorsJSON, 0)
	c.JSON(200, operators)
}
func (r *RestServer) getOperatorProducts(c *gin.Context) {
	// Extract the productId from the URL parameter
	productId := c.Param("productId")
	if productId == "" {
		r.Log.Infof("Missing productId")
		c.JSON(400, gin.H{"error": "productId is required"})
		return
	}
	// Convert productId to int
	productIdInt, err := strconv.Atoi(productId)
	if err != nil {
		r.Log.Errorf("Invalid productId: %v", err)
		c.JSON(400, gin.H{"error": "Invalid productId"})
		return
	}
	nullOperator := sql.NullInt32{
		Int32: int32(productIdInt),
		Valid: true, // Valid = true since we have a valid ID
	}

	// Check if the data is already cached
	cacheKey := "operators_" + productId
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		// Cache hit, return the cached data
		r.Log.Infof("Cache hit for operators")
		var operators []db.TblOperator
		json.Unmarshal([]byte(cachedData), &operators)
		c.JSON(200, operators)
	} else {
		// Cache miss, fetch from the database
		r.Log.Infof("Cache miss for operators")

		// Call the service layer method to get operator products
		operators, err := r.Db.GetOperatorProducts(context.Background(), nullOperator)
		if err != nil {
			r.Log.Errorf("Failed to fetch operators: %v", err)
			c.JSON(500, gin.H{"error": "Failed to fetch operators"})
			return
		}

		// Store fetched data into the cache
		operatorsJSON, _ := json.Marshal(operators)
		r.RedisClient.Set(context.Background(), cacheKey, operatorsJSON, 0)

		// Return the fetched operators
		c.JSON(200, operators)
	}
}

func (r *RestServer) getProductImage(c *gin.Context) {
	productImage := c.Param("product_image")
	cacheKey := "product_image_" + productImage

	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for product image %s", productImage)
		var productImageData sql.NullString
		if err := json.Unmarshal([]byte(cachedData), &productImageData); err == nil {
			c.JSON(200, productImageData)
			return
		}
		r.Log.Errorf("Failed to unmarshal cached data: %v", err)
	}
	productImageNullString := sql.NullString{String: productImage, Valid: productImage != ""}

	r.Log.Infof("Cache miss for product image %s", productImage)

	productImageData, err := r.Db.GetProductImage(context.Background(), productImageNullString)
	if err != nil {
		r.Log.Errorf("Failed to fetch product image: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch product image"})
		return
	}

	productImageJSON, err := json.Marshal(productImageData)
	if err == nil {
		r.RedisClient.Set(context.Background(), cacheKey, productImageJSON, 0)
	} else {
		r.Log.Errorf("Failed to marshal product image data for cache: %v", err)
	}

	c.JSON(200, productImageData)
}
