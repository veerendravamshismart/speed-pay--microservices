package rest

import (
	"context"
	"encoding/json"
	
	"github.com/speedpay/internal/db/dealer-api"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"
	    "net/http"
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
	router.GET("/get-countries", r.getAllCountries)
	router.GET("/get-regions", r.getAllRegions)
	router.GET("/get-cities", r.getAllCities)
	router.GET("/get-areas", r.getAllAreas)
	router.GET("/get-currencies", 	r.GetAllCurrencies)
	router.GET("/get-number-series", r.getAllNumberSeries)
	router.GET("/get-service-types", r.getAllServiceTypes)

}

// getAllCountries handles GET /countries.
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
	countries, err := r.Db.GetAllCountries(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch countries: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch countries"})
		return
	}

	countriesJSON, _ := json.Marshal(countries)
	r.RedisClient.Set(context.Background(), cacheKey, countriesJSON, 0)
	c.JSON(200, countries)
}

// getAllRegions handles GET /regions.
func (r *RestServer) getAllRegions(c *gin.Context) {
	cacheKey := "regions"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err != nil {
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
	} else {
		r.Log.Infof("Cache hit for regions")
		var regions []db.TblRegion
		json.Unmarshal([]byte(cachedData), &regions)
		c.JSON(200, regions)
	}
	
	
}

// getAllCities handles GET /cities.
func (r *RestServer) getAllCities(c *gin.Context) {
	cacheKey := "cities"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for cities")
		var cities []db.TblCity
		json.Unmarshal([]byte(cachedData), &cities)
		c.JSON(200, cities)
		return
	}

	r.Log.Infof("Cache miss for cities")
	cities, err := r.Db.GetAllCities(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch cities: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch cities"})
		return
	}

	citiesJSON, _ := json.Marshal(cities)
	r.RedisClient.Set(context.Background(), cacheKey, citiesJSON, 0)
	c.JSON(200, cities)
}

// getAllAreas handles GET /areas.
func (r *RestServer) getAllAreas(c *gin.Context) {
	cacheKey := "areas"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for areas")
		var areas []db.TblArea
		json.Unmarshal([]byte(cachedData), &areas)
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


func (r *RestServer) GetAllCurrencies(c *gin.Context) {
	cacheKey := "currencies"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for currencies")
		var currencies []db.TblCurrency
		json.Unmarshal([]byte(cachedData), &currencies)
		c.JSON(200, currencies)
		return
	}

	r.Log.Infof("Cache miss for currencies")
	countries, err := r.Db.GetAllCurrencies(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch curencies: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch curencies"})
		return
	}

	countriesJSON, _ := json.Marshal(countries)
	r.RedisClient.Set(context.Background(), cacheKey, countriesJSON, 0)
	c.JSON(200, countries)
}
// getAllNumberSeries handles GET /number-series.
func (r *RestServer) getAllNumberSeries(c *gin.Context) {
	cacheKey := "number_series"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for number series")
		var numberSeries []db.TblNumberSeries
		json.Unmarshal([]byte(cachedData), &numberSeries)
		c.JSON(http.StatusOK, numberSeries)
		return
	}

	r.Log.Infof("Cache miss for number series")
	numberSeries, err := r.Db.GetAllNumberSeries(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch number series: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch number series"})
		return
	}

	numberSeriesJSON, _ := json.Marshal(numberSeries)
	r.RedisClient.Set(context.Background(), cacheKey, numberSeriesJSON, 0)
	c.JSON(http.StatusOK, numberSeries)
}

// getAllServiceTypes handles GET /service-types.
func (r *RestServer) getAllServiceTypes(c *gin.Context) {
	cacheKey := "service_types"
	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for service types")
		var serviceTypes []db.TblServiceType
		json.Unmarshal([]byte(cachedData), &serviceTypes)
		c.JSON(http.StatusOK, serviceTypes)
		return
	}

	r.Log.Infof("Cache miss for service types")
	serviceTypes, err := r.Db.GetAllServiceTypes(context.Background())
	if err != nil {
		r.Log.Errorf("Failed to fetch service types: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch service types"})
		return
	}

	serviceTypesJSON, _ := json.Marshal(serviceTypes)
	r.RedisClient.Set(context.Background(), cacheKey, serviceTypesJSON, 0)
	c.JSON(http.StatusOK, serviceTypes)
}
