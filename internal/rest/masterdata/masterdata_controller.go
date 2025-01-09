package rest

import (
	"context"
	"encoding/json"
	"strconv"
	"database/sql"

	"github.com/speedpay/internal/db"

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
	router.GET("/get-countries", r.getAllCountries)
	router.GET("/get-regions", r.getAllRegions)
	router.GET("/get-cities", r.getAllCities)
	router.GET("/get-areas", r.getAllAreas)
	router.GET("/get-currencies", 	r.GetAllCurrencies)
	router.GET("/countries/:id", r.getCountryByID)
	router.GET("/currencies/:id", r.getCurrencyByID)
	router.GET("/regions/country/:id", r.getRegionsByCountryID)
	router.GET("/cities/region/:id", r.getCitiesByRegionID)
	router.GET("/areas/city/:id", r.getAreasByCityID)
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
	if err =! nil {
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
	
	r.Log.Infof("Cache hit for regions")
	var regions []db.TblRegion
	json.Unmarshal([]byte(cachedData), &regions)
	c.JSON(200, regions)
	return
	
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
// getCountryByID handles GET /countries/:id.
func (r *RestServer) getCountryByID(c *gin.Context) {
	id := c.Param("id")
	cacheKey := "country_" + id

	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for country ID %s", id)
		var country db.TblCountry
		json.Unmarshal([]byte(cachedData), &country)
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

// getCurrencyByID handles GET /currencies/:id.
func (r *RestServer) getCurrencyByID(c *gin.Context) {
	id := c.Param("id")
	cacheKey := "currency_" + id

	cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
	if err == nil {
		r.Log.Infof("Cache hit for currency ID %s", id)
		var currency db.TblCurrency
		json.Unmarshal([]byte(cachedData), &currency)
		c.JSON(200, currency)
		return
	}

	r.Log.Infof("Cache miss for currency ID %s", id)
	currencyID, err := strconv.Atoi(id)
	if err != nil {
		r.Log.Errorf("Invalid currency ID: %v", err)
		c.JSON(400, gin.H{"error": "Invalid currency ID"})
		return
	}

	currency, err := r.Db.GetCurrencyByID(context.Background(), int32(currencyID))
	if err != nil {
		r.Log.Errorf("Failed to fetch currency: %v", err)
		c.JSON(500, gin.H{"error": "Failed to fetch currency"})
		return
	}

	currencyJSON, _ := json.Marshal(currency)
	r.RedisClient.Set(context.Background(), cacheKey, currencyJSON, 0)
	c.JSON(200, currency)
}

// getRegionsByCountryID handles GET /regions/country/:id.
func (r *RestServer) getRegionsByCountryID(c *gin.Context) {
    id := c.Param("id")
    cacheKey := "regions_country_" + id

    cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
    if err == nil {
        r.Log.Infof("Cache hit for regions by country ID %s", id)
        var regions []db.TblRegion
        json.Unmarshal([]byte(cachedData), &regions)
        c.JSON(200, regions)
        return
    }

    r.Log.Infof("Cache miss for regions by country ID %s", id)
    countryID, err := strconv.Atoi(id)
    if err != nil {
        r.Log.Errorf("Invalid country ID: %v", err)
        c.JSON(400, gin.H{"error": "Invalid country ID"})
        return
    }

    // Wrap the countryID in sql.NullInt32
    nullCountryID := sql.NullInt32{
        Int32: int32(countryID),
        Valid: true, // Valid = true since we have a valid ID
    }

    regions, err := r.Db.GetRegionsByCountryID(context.Background(), nullCountryID)
    if err != nil {
        r.Log.Errorf("Failed to fetch regions: %v", err)
        c.JSON(500, gin.H{"error": "Failed to fetch regions"})
        return
    }

    regionsJSON, _ := json.Marshal(regions)
    r.RedisClient.Set(context.Background(), cacheKey, regionsJSON, 0)
    c.JSON(200, regions)
}

// getCitiesByRegionID handles GET /cities/region/:id.
func (r *RestServer) getCitiesByRegionID(c *gin.Context) {
    id := c.Param("id")
    cacheKey := "cities_region_" + id

    cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
    if err == nil {
        r.Log.Infof("Cache hit for cities by region ID %s", id)
        var cities []db.TblCity
        json.Unmarshal([]byte(cachedData), &cities)
        c.JSON(200, cities)
        return
    }

    r.Log.Infof("Cache miss for cities by region ID %s", id)
    regionID, err := strconv.Atoi(id)
    if err != nil {
        r.Log.Errorf("Invalid region ID: %v", err)
        c.JSON(400, gin.H{"error": "Invalid region ID"})
        return
    }

    // Wrap the regionID in sql.NullInt32
    nullRegionID := sql.NullInt32{
        Int32: int32(regionID),
        Valid: true, // Valid = true since we have a valid ID
    }

    cities, err := r.Db.GetCitiesByRegionID(context.Background(), nullRegionID)
    if err != nil {
        r.Log.Errorf("Failed to fetch cities: %v", err)
        c.JSON(500, gin.H{"error": "Failed to fetch cities"})
        return
    }

    citiesJSON, _ := json.Marshal(cities)
    r.RedisClient.Set(context.Background(), cacheKey, citiesJSON, 0)
    c.JSON(200, cities)
}

// getAreasByCityID handles GET /areas/city/:id.
func (r *RestServer) getAreasByCityID(c *gin.Context) {
    id := c.Param("id")
    cacheKey := "areas_city_" + id

    cachedData, err := r.RedisClient.Get(context.Background(), cacheKey).Result()
    if err == nil {
        r.Log.Infof("Cache hit for areas by city ID %s", id)
        var areas []db.TblArea
        json.Unmarshal([]byte(cachedData), &areas)
        c.JSON(200, areas)
        return
    }

    r.Log.Infof("Cache miss for areas by city ID %s", id)
    cityID, err := strconv.Atoi(id)
    if err != nil {
        r.Log.Errorf("Invalid city ID: %v", err)
        c.JSON(400, gin.H{"error": "Invalid city ID"})
        return
    }

    // Wrap the cityID in sql.NullInt32
    nullCityID := sql.NullInt32{
        Int32: int32(cityID),
        Valid: true, // Valid = true since we have a valid ID
    }

    areas, err := r.Db.GetAreasByCityID(context.Background(), nullCityID)
    if err != nil {
        r.Log.Errorf("Failed to fetch areas: %v", err)
        c.JSON(500, gin.H{"error": "Failed to fetch areas"})
        return
    }

    areasJSON, _ := json.Marshal(areas)
    r.RedisClient.Set(context.Background(), cacheKey, areasJSON, 0)
    c.JSON(200, areas)
}

