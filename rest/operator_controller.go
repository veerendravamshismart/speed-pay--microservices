package rest

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/speedpay/cmd/operator-service/pkg/operator"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8" // Redis/Dragonfly client
	"go.uber.org/zap"
)

type OperatorController struct {
	db          *operator.Queries
	log         *zap.SugaredLogger
	redisClient *redis.Client
}

// NewOperatorController creates a new instance of OperatorController
func NewOperatorController(db *operator.Queries, log *zap.SugaredLogger, redisClient *redis.Client) *OperatorController {
	return &OperatorController{
		db:          db,
		log:         log,
		redisClient: redisClient,
	}
}

// RegisterRoutes registers the routes for the operator controller
func (ctrl *OperatorController) RegisterRoutes(router *gin.Engine) {
	router.POST("/operators", ctrl.createOperator)
	router.GET("/operators", ctrl.getAllOperators)
	router.GET("/operators/:id", ctrl.getOperatorByID)
	router.PUT("/operators/:id", ctrl.updateOperator)
	router.DELETE("/operators/:id", ctrl.deleteOperator)
}

// createOperator creates a new operator in the database
func (ctrl *OperatorController) createOperator(c *gin.Context) {
	var req operator.CreateOperatorParams
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.log.Errorf("Invalid request: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	if err := ctrl.db.CreateOperator(context.Background(), req); err != nil {
		ctrl.log.Errorf("Failed to create operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create operator"})
		return
	}

	// Clear the cached data in Dragonfly (Redis)
	ctrl.redisClient.Del(context.Background(), "operators")

	c.JSON(http.StatusCreated, gin.H{"message": "Operator created successfully"})
}

func (ctrl *OperatorController) getAllOperators(c *gin.Context) {
	// Log the start of the function execution
	ctrl.log.Info("Fetching all operators")

	// First check if the data is available in cache
	ctrl.log.Info("Checking Redis cache for operators")
	cachedData, err := ctrl.redisClient.Get(c, "operators").Result()

	if err == redis.Nil {
		// Data not found in cache, fetch from the database
		ctrl.log.Info("Cache miss, fetching operators from the database")

		operators, err := ctrl.db.GetAllOperators(context.Background())
		if err != nil {
			// Log the database error
			ctrl.log.Errorf("Failed to fetch operators from DB: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operators from database"})
			return
		}

		// Log successful database retrieval
		ctrl.log.Infof("Successfully fetched %d operators from the database", len(operators))

		// Serialize the result into JSON before caching
		operatorsJson, err := json.Marshal(operators)
		if err != nil {
			// Log serialization error
			ctrl.log.Errorf("Failed to serialize operators: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operators"})
			return
		}

		// Log successful serialization
		ctrl.log.Info("Successfully serialized operators into JSON")

		// Cache the result in Dragonfly (Redis)
		err = ctrl.redisClient.Set(context.Background(), "operators", operatorsJson, 0).Err()
		if err != nil {
			// Log error if cache operation fails
			ctrl.log.Errorf("Failed to set operators cache in Redis: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to set operators cache"})
			return
		}

		// Log successful caching
		ctrl.log.Info("Successfully cached operators in Redis")

		// Respond with the data
		c.JSON(http.StatusOK, operators)
		return
	} else if err != nil {
		// Handle Redis errors (e.g., connection issues)
		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
		return
	}

	// Log cache hit
	ctrl.log.Info("Cache hit, deserializing operators from cache")

	// If cache exists, deserialize the cached data
	var cachedOperators []operator.Operator // Assuming operator.Operator is the struct type
	if err := json.Unmarshal([]byte(cachedData), &cachedOperators); err != nil {
		// Log deserialization error
		ctrl.log.Errorf("Failed to deserialize operators from cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operators from cache"})
		return
	}

	// Log successful deserialization
	ctrl.log.Info("Successfully deserialized operators from cache")

	// Respond with the cached data
	c.JSON(http.StatusOK, cachedOperators)
}
func (ctrl *OperatorController) getOperatorByID(c *gin.Context) {
	// Step 1: Parse the ID from the URL parameter
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		// If the ID is not valid, log the error and return a bad request response
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Log the ID being requested
	ctrl.log.Infof("Fetching operator with ID: %d", id)

	// Step 2: Check the cache first
	cacheKey := "operator:" + strconv.Itoa(id) // Cache key for the specific operator by ID
	cachedData, err := ctrl.redisClient.Get(c, cacheKey).Result()

	if err == redis.Nil {
		// Cache miss: If the operator is not in cache, fetch from the database
		ctrl.log.Info("Cache miss for operator ID %d, fetching from database", id)

		operator, err := ctrl.db.GetOperatorByID(context.Background(), int32(id))
		if err != nil {
			// If the database query fails, log the error and return an internal server error response
			ctrl.log.Errorf("Failed to fetch operator with ID %d: %v", id, err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operator"})
			return
		}

		// Cache the operator data after fetching from the database
		operatorJson, err := json.Marshal(operator)
		if err != nil {
			ctrl.log.Errorf("Failed to serialize operator: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operator"})
			return
		}

		// Cache the result in Redis with an expiration time (e.g., 1 hour)
		ctrl.redisClient.Set(context.Background(), cacheKey, operatorJson, 0) // Set without expiry

		// Log the cache store operation
		ctrl.log.Infof("Successfully fetched operator ID %d from database and cached it", id)

		// Respond with the operator data
		c.JSON(http.StatusOK, operator)
		return
	} else if err != nil {
		// Handle Redis errors (e.g., connection issues)
		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
		return
	}

	// Cache hit: If data is found in the cache, deserialize the cached data
	var cachedOperator operator.Operator
	if err := json.Unmarshal([]byte(cachedData), &cachedOperator); err != nil {
		ctrl.log.Errorf("Failed to deserialize operator from cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operator from cache"})
		return
	}

	// Log the cache hit
	ctrl.log.Infof("Cache hit for operator ID %d, returning data from cache", id)

	// Respond with the cached data
	c.JSON(http.StatusOK, cachedOperator)
}

// updateOperator updates an existing operator in the database
func (ctrl *OperatorController) updateOperator(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var req operator.UpdateOperatorParams
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.log.Errorf("Invalid request: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	req.ID = int32(id)
	if err := ctrl.db.UpdateOperator(context.Background(), req); err != nil {
		ctrl.log.Errorf("Failed to update operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update operator"})
		return
	}

	// Clear the cached data in Dragonfly (Redis)
	ctrl.redisClient.Del(context.Background(), "operators")

	c.JSON(http.StatusOK, gin.H{"message": "Operator updated successfully"})
}

// deleteOperator deletes an operator by ID from the database
func (ctrl *OperatorController) deleteOperator(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	if err := ctrl.db.DeleteOperator(context.Background(), int32(id)); err != nil {
		ctrl.log.Errorf("Failed to delete operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete operator"})
		return
	}

	// Clear the cached data in Dragonfly (Redis)
	ctrl.redisClient.Del(context.Background(), "operators")

	c.JSON(http.StatusOK, gin.H{"message": "Operator deleted successfully"})
}
