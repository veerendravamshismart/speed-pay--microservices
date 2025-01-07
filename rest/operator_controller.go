// package rest

// import (
// 	"context"
// 	"database/sql"
// 	"encoding/json"
// 	"net/http"
// 	"strconv"
// 	"time"

// 	"github.com/gin-gonic/gin"
// 	"github.com/go-redis/redis/v8" // Redis/Dragonfly client
// 	"github.com/speedpay/cmd/operator-service/pkg/operator"
// 	"go.uber.org/zap"
// )

// // operator_controller.go

// type OperatorController struct {
// 	db          *operator.Queries
// 	log         *zap.SugaredLogger
// 	redisClient *redis.Client
// }

// func NewOperatorController(db *operator.Queries, log *zap.SugaredLogger, redisClient *redis.Client) *OperatorController {
// 	return &OperatorController{
// 		db:          db,
// 		log:         log,
// 		redisClient: redisClient,
// 	}
// }

// // RegisterRoutes registers the routes for the operator controller
// func (ctrl *OperatorController) RegisterRoutes(router *gin.Engine) {
// 	router.POST("/new-operator", ctrl.createOperator)
// 	router.GET("/get-operators", ctrl.getAllOperators)
// 	router.GET("/get-operator/:id", ctrl.getOperatorByID)
// 	router.PUT("/update-operator-status/", ctrl.updateOperatorStatus)
// 	router.PUT("/update-operator/", ctrl.updateOperator)
// }

// // createOperator creates a new operator in the database
// func (ctrl *OperatorController) createOperator(c *gin.Context) {
// 	var req operator.CreateOperatorParams
// 	if err := c.ShouldBindJSON(&req); err != nil {
// 		ctrl.log.Errorf("Invalid request: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
// 		return
// 	}

// 	// Insert operator into DB
// 	operatorID, err := ctrl.db.CreateOperator(context.Background(), req)
// 	if err != nil {
// 		ctrl.log.Errorf("Failed to create operator: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create operator"})
// 		return
// 	}

// 	// Clear Redis cache
// 	ctrl.redisClient.Del(context.Background(), "operators")
// 	c.JSON(http.StatusCreated, gin.H{"operator_id": operatorID})
// }

// // getAllOperators retrieves all operators from the database or cache
// func (ctrl *OperatorController) getAllOperators(c *gin.Context) {
// 	ctrl.log.Info("Fetching all operators")

// 	// Check Redis Cache first
// 	cachedData, err := ctrl.redisClient.Get(context.Background(), "operators").Result()
// 	if err == redis.Nil {
// 		ctrl.log.Infof("Cache hit for regions")

// 		// Cache miss - Fetch from DB
// 		operators, err := ctrl.db.GetAllOperators(context.Background())
// 		if err != nil {
// 			ctrl.log.Errorf("Failed to fetch operators from DB: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operators"})
// 			return
// 		}

// 		// Cache the data for 30 minutes
// 		operatorsJSON, err := json.Marshal(operators)
// 		if err != nil {
// 			ctrl.log.Errorf("Failed to serialize operators: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operators"})
// 			return
// 		}
// 		ctrl.redisClient.Set(context.Background(), "operators", operatorsJSON, 30*time.Minute)

// 		// Return the operators
// 		c.JSON(http.StatusOK, operators)
// 		return
// 	} else if err != nil {
// 		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
// 		return
// 	}

// 	// Cache hit - Deserialize and return the data
// 	var cachedOperators []operator.TblOperator
// 	if err := json.Unmarshal([]byte(cachedData), &cachedOperators); err != nil {
// 		ctrl.log.Errorf("Failed to deserialize operators: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operators"})
// 		return
// 	}

// 	c.JSON(http.StatusOK, cachedOperators)
// }

// // getOperatorByID retrieves a specific operator by its ID
// func (ctrl *OperatorController) getOperatorByID(c *gin.Context) {
// 	id, err := strconv.Atoi(c.Param("id"))
// 	if err != nil {
// 		ctrl.log.Errorf("Invalid ID: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
// 		return
// 	}

// 	// Check Redis cache for the operator
// 	cacheKey := "operator:" + strconv.Itoa(id)
// 	cachedData, err := ctrl.redisClient.Get(context.Background(), cacheKey).Result()
// 	if err == redis.Nil {
// 		// Cache miss - Fetch from DB
// 		operator, err := ctrl.db.GetOperatorByID(context.Background(), int32(id))
// 		if err != nil {
// 			ctrl.log.Errorf("Failed to fetch operator with ID %d: %v", id, err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operator"})
// 			return
// 		}

// 		// Cache operator data
// 		operatorJSON, err := json.Marshal(operator)
// 		if err != nil {
// 			ctrl.log.Errorf("Failed to serialize operator: %v", err)
// 			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operator"})
// 			return
// 		}
// 		ctrl.redisClient.Set(context.Background(), cacheKey, operatorJSON, 30*time.Minute)
// 		c.JSON(http.StatusOK, operator)
// 		return
// 	} else if err != nil {
// 		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
// 		return
// 	}

// 	var cachedOperator operator.TblOperator
// 	if err := json.Unmarshal([]byte(cachedData), &cachedOperator); err != nil {
// 		ctrl.log.Errorf("Failed to deserialize operator: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operator"})
// 		return
// 	}

// 	c.JSON(http.StatusOK, cachedOperator)
// }

// func (ctrl *OperatorController) updateOperatorStatus(c *gin.Context) {
// 	var req struct {
// 		OperatorID string `json:"operatorId"` // ID as string to match user input
// 		Status     string `json:"status"`     // Status to update
// 	}

// 	if err := c.ShouldBindJSON(&req); err != nil {
// 		ctrl.log.Errorf("Invalid request: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
// 		return
// 	}

// 	id, err := strconv.Atoi(req.OperatorID)
// 	if err != nil {
// 		ctrl.log.Errorf("Invalid ID: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
// 		return
// 	}

// 	var status sql.NullInt32
// 	if req.Status == "" {
// 		status = sql.NullInt32{Valid: false} // NULL value
// 	} else {
// 		statusInt, err := strconv.Atoi(req.Status)
// 		if err != nil {
// 			ctrl.log.Errorf("Invalid status value: %v", err)
// 			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid status value"})
// 			return
// 		}
// 		status = sql.NullInt32{Int32: int32(statusInt), Valid: true}
// 	}

// 	params := operator.UpdateOperatorStatusParams{
// 		Status:     status,
// 		OperatorID: int32(id),
// 	}

// 	// Perform the status update
// 	operatorID, err := ctrl.db.UpdateOperatorStatus(context.Background(), params)
// 	if err != nil {
// 		ctrl.log.Errorf("Failed to update operator status: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update operator status"})
// 		return
// 	}

// 	// Optionally clear caches or handle other post-update tasks
// 	ctrl.redisClient.Del(context.Background(), "operators")
// 	ctrl.redisClient.Del(context.Background(), "operator:"+strconv.Itoa(id))

// 	c.JSON(http.StatusOK, gin.H{"operator_id": operatorID})
// }

// // updateOperator updates the operator details using data from the request body
// func (ctrl *OperatorController) updateOperator(c *gin.Context) {
// 	var req struct {
// 		OperatorID   string `json:"operatorId"`
// 		OperatorName string `json:"operatorName"`
// 		Status       string `json:"status"`
// 	}

// 	if err := c.ShouldBindJSON(&req); err != nil {
// 		ctrl.log.Errorf("Invalid request: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
// 		return
// 	}

// 	id, err := strconv.Atoi(req.OperatorID)
// 	if err != nil {
// 		ctrl.log.Errorf("Invalid ID: %v", err)
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
// 		return
// 	}

// 	// Convert OperatorName to sql.NullString
// 	operatorName := sql.NullString{String: req.OperatorName, Valid: req.OperatorName != ""}

// 	// Prepare status
// 	var status sql.NullInt32
// 	if req.Status == "" {
// 		status = sql.NullInt32{Valid: false} // NULL value for status
// 	} else {
// 		statusInt, err := strconv.Atoi(req.Status)
// 		if err != nil {
// 			ctrl.log.Errorf("Invalid status value: %v", err)
// 			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid status value"})
// 			return
// 		}
// 		status = sql.NullInt32{Int32: int32(statusInt), Valid: true}
// 	}

// 	// Prepare parameters for updating the operator
// 	params := operator.UpdateOperatorParams{
// 		OperatorID:   int32(id),
// 		OperatorName: operatorName,
// 		Status:       status,
// 	}

// 	// Perform the update operation
// 	operatorID, err := ctrl.db.UpdateOperator(context.Background(), params)
// 	if err != nil {
// 		ctrl.log.Errorf("Failed to update operator: %v", err)
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update operator"})
// 		return
// 	}

// 	// Clear Redis cache
// 	ctrl.redisClient.Del(context.Background(), "operators")
// 	ctrl.redisClient.Del(context.Background(), "operator:"+strconv.Itoa(id))

// 	c.JSON(http.StatusOK, gin.H{"operator_id": operatorID})
// }

package rest

import (
	"context"
	"database/sql"
	"encoding/json"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8" // Redis/Dragonfly client
	"github.com/speedpay/cmd/operator-service/pkg/operator"
	"go.uber.org/zap"
)

// operator_controller.go

type OperatorController struct {
	db          *operator.Queries
	log         *zap.SugaredLogger
	redisClient *redis.Client
}

func NewOperatorController(db *operator.Queries, log *zap.SugaredLogger, redisClient *redis.Client) *OperatorController {
	return &OperatorController{
		db:          db,
		log:         log,
		redisClient: redisClient,
	}
}

// RegisterRoutes registers the routes for the operator controller
func (ctrl *OperatorController) RegisterRoutes(router *gin.Engine) {
	router.POST("/new-operator", ctrl.createOperator)
	router.GET("/get-operators", ctrl.getAllOperators)
	router.GET("/get-operator/:id", ctrl.getOperatorByID)
	router.PUT("/update-operator-status/", ctrl.updateOperatorStatus)
	router.PUT("/update-operator/", ctrl.updateOperator)
}

// createOperator creates a new operator in the database
func (ctrl *OperatorController) createOperator(c *gin.Context) {
	var req operator.CreateOperatorParams
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.log.Errorf("Invalid request: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// Insert operator into DB
	operatorID, err := ctrl.db.CreateOperator(context.Background(), req)
	if err != nil {
		ctrl.log.Errorf("Failed to create operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create operator"})
		return
	}

	// Clear Redis cache
	ctrl.redisClient.Del(context.Background(), "operators")
	c.JSON(http.StatusCreated, gin.H{"operator_id": operatorID})
}

// getAllOperators retrieves all operators from the database or cache
func (ctrl *OperatorController) getAllOperators(c *gin.Context) {
	ctrl.log.Info("Fetching all operators")

	// Check Redis Cache first
	cachedData, err := ctrl.redisClient.Get(context.Background(), "operators").Result()
	if err == redis.Nil {
		ctrl.log.Info("Cache miss for operators")

		// Cache miss - Fetch from DB
		operators, err := ctrl.db.GetAllOperators(context.Background())
		if err != nil {
			ctrl.log.Errorf("Failed to fetch operators from DB: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operators"})
			return
		}

		// Cache the data for 30 minutes
		operatorsJSON, err := json.Marshal(operators)
		if err != nil {
			ctrl.log.Errorf("Failed to serialize operators: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operators"})
			return
		}
		ctrl.redisClient.Set(context.Background(), "operators", operatorsJSON, 30*time.Minute)

		// Return the operators
		c.JSON(http.StatusOK, operators)
		return
	} else if err != nil {
		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
		return
	}

	// Cache hit - Deserialize and return the data
	ctrl.log.Info("Cache hit for operators")
	var cachedOperators []operator.TblOperator
	if err := json.Unmarshal([]byte(cachedData), &cachedOperators); err != nil {
		ctrl.log.Errorf("Failed to deserialize operators: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operators"})
		return
	}

	c.JSON(http.StatusOK, cachedOperators)
}

// getOperatorByID retrieves a specific operator by its ID
func (ctrl *OperatorController) getOperatorByID(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Check Redis cache for the operator
	cacheKey := "operator:" + strconv.Itoa(id)
	cachedData, err := ctrl.redisClient.Get(context.Background(), cacheKey).Result()
	if err == redis.Nil {
		ctrl.log.Infof("Cache miss for operator ID: %d", id)

		// Cache miss - Fetch from DB
		operator, err := ctrl.db.GetOperatorByID(context.Background(), int32(id))
		if err != nil {
			ctrl.log.Errorf("Failed to fetch operator with ID %d: %v", id, err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch operator"})
			return
		}

		// Cache operator data
		operatorJSON, err := json.Marshal(operator)
		if err != nil {
			ctrl.log.Errorf("Failed to serialize operator: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to serialize operator"})
			return
		}
		ctrl.redisClient.Set(context.Background(), cacheKey, operatorJSON, 30*time.Minute)
		c.JSON(http.StatusOK, operator)
		return
	} else if err != nil {
		ctrl.log.Errorf("Error accessing Redis cache: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error accessing cache"})
		return
	}

	// Cache hit - Deserialize and return the data
	ctrl.log.Infof("Cache hit for operator ID: %d", id)
	var cachedOperator operator.TblOperator
	if err := json.Unmarshal([]byte(cachedData), &cachedOperator); err != nil {
		ctrl.log.Errorf("Failed to deserialize operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to deserialize operator"})
		return
	}

	c.JSON(http.StatusOK, cachedOperator)
}

func (ctrl *OperatorController) updateOperatorStatus(c *gin.Context) {
	var req struct {
		OperatorID string `json:"operatorId"` // ID as string to match user input
		Status     string `json:"status"`     // Status to update
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.log.Errorf("Invalid request: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	id, err := strconv.Atoi(req.OperatorID)
	if err != nil {
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var status sql.NullInt32
	if req.Status == "" {
		status = sql.NullInt32{Valid: false} // NULL value
	} else {
		statusInt, err := strconv.Atoi(req.Status)
		if err != nil {
			ctrl.log.Errorf("Invalid status value: %v", err)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid status value"})
			return
		}
		status = sql.NullInt32{Int32: int32(statusInt), Valid: true}
	}

	params := operator.UpdateOperatorStatusParams{
		Status:     status,
		OperatorID: int32(id),
	}

	// Perform the status update
	operatorID, err := ctrl.db.UpdateOperatorStatus(context.Background(), params)
	if err != nil {
		ctrl.log.Errorf("Failed to update operator status: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update operator status"})
		return
	}

	// Optionally clear caches or handle other post-update tasks
	ctrl.redisClient.Del(context.Background(), "operators")
	ctrl.redisClient.Del(context.Background(), "operator:"+strconv.Itoa(id))

	c.JSON(http.StatusOK, gin.H{"operator_id": operatorID})
}

// updateOperator updates the operator details using data from the request body
func (ctrl *OperatorController) updateOperator(c *gin.Context) {
	var req struct {
		OperatorID   string `json:"operatorId"`
		OperatorName string `json:"operatorName"`
		Status       string `json:"status"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.log.Errorf("Invalid request: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	id, err := strconv.Atoi(req.OperatorID)
	if err != nil {
		ctrl.log.Errorf("Invalid ID: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Convert OperatorName to sql.NullString
	operatorName := sql.NullString{String: req.OperatorName, Valid: req.OperatorName != ""}

	// Prepare status
	var status sql.NullInt32
	if req.Status == "" {
		status = sql.NullInt32{Valid: false} // NULL value for status
	} else {
		statusInt, err := strconv.Atoi(req.Status)
		if err != nil {
			ctrl.log.Errorf("Invalid status value: %v", err)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid status value"})
			return
		}
		status = sql.NullInt32{Int32: int32(statusInt), Valid: true}
	}

	// Prepare parameters for updating the operator
	params := operator.UpdateOperatorParams{
		OperatorID:   int32(id),
		OperatorName: operatorName,
		Status:       status,
	}

	// Perform the update operation
	operatorID, err := ctrl.db.UpdateOperator(context.Background(), params)
	if err != nil {
		ctrl.log.Errorf("Failed to update operator: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update operator"})
		return
	}

	// Clear Redis cache
	ctrl.redisClient.Del(context.Background(), "operators")
	ctrl.redisClient.Del(context.Background(), "operator:"+strconv.Itoa(id))

	c.JSON(http.StatusOK, gin.H{"operator_id": operatorID})
}
