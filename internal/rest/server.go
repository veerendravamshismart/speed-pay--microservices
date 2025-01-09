// package rest

// import (
// 	"context"
// 	"database/sql"
// 	"log"
// 	"os"

// 	"github.com/gin-gonic/gin"
// 	"github.com/speedpay/cmd/masterdata-service/pkg/db"

// 	"github.com/go-redis/redis/v8" // Redis client
// 	"github.com/joho/godotenv"
// 	_ "github.com/lib/pq"
// 	"go.uber.org/zap"
// )

// // Init initializes the shared components and returns them for use in microservices.
// func Init() (*gin.Engine, *db.Queries, *zap.SugaredLogger, *redis.Client) {
// 	// Load environment variables from .env file
// 	if err := godotenv.Load(); err != nil {
// 		log.Println("No .env file found. Falling back to system environment variables.")
// 	}

// 	// Get environment variables
// 	dbURL := os.Getenv("DATABASE_URL")
// 	redisAddr := os.Getenv("REDIS_ADDR")
// 	redisPass := os.Getenv("REDIS_PASS")
// 	port := os.Getenv("PORT")

// 	if port == "" {
// 		port = "8080" // Default port if not set
// 	}

// 	// Initialize logger
// 	logger, _ := zap.NewProduction()
// 	defer logger.Sync()
// 	sugar := logger.Sugar()

// 	// Initialize Redis client
// 	redisClient := redis.NewClient(&redis.Options{
// 		Addr:     redisAddr,
// 		Password: redisPass, // Redis password (if set)
// 	})

// 	// Test Redis connection
// 	if _, err := redisClient.Ping(context.Background()).Result(); err != nil {
// 		sugar.Fatalf("Failed to connect to Redis: %v", err)
// 	}
// 	sugar.Info("Successfully connected to Redis")

// 	// Initialize PostgreSQL database connection
// 	dbConn, err := sql.Open("postgres", dbURL)
// 	if err != nil {
// 		sugar.Fatalf("Failed to connect to the database: %v", err)
// 	}

// 	// Initialize sqlc queries
// 	queries := db.New(dbConn)

// 	// Initialize the REST server
// 	router := gin.Default()

// 	sugar.Infof("Initialization complete")
// 	return router, queries, sugar, redisClient
// }

package rest

import (
	"context"
	"database/sql"
	"log"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"github.com/speedpay/cmd/masterdata-service/pkg/db"
	"github.com/spf13/viper"
	"go.uber.org/zap"

	_ "github.com/lib/pq"
)

// Init initializes the shared components and returns them for use in microservices.
func Init() (*gin.Engine, *db.Queries, *zap.SugaredLogger, *redis.Client) {
	// Load configuration from config.yaml
	viper.SetConfigName("config")          // Name of the config file without extension
	viper.SetConfigType("yaml")            // Specify the file type
	viper.AddConfigPath("./common/config") // Path to look for the config file

	if err := viper.ReadInConfig(); err != nil {
		log.Fatalf("Error reading config file: %v", err)
	}

	// Get configurations
	dbURL := viper.GetString("database.url")
	redisAddr := viper.GetString("redis.address")
	redisPass := viper.GetString("redis.password")
	port := viper.GetString("server.port")

	// Initialize logger
	logger, _ := zap.NewProduction()
	defer logger.Sync()
	sugar := logger.Sugar()

	// Initialize Redis client
	redisClient := redis.NewClient(&redis.Options{
		Addr:     redisAddr,
		Password: redisPass, // Redis password (if set)
	})

	// Test Redis connection
	if _, err := redisClient.Ping(context.Background()).Result(); err != nil {
		sugar.Fatalf("Failed to connect to Redis: %v", err)
	}
	sugar.Info("Successfully connected to Redis")

	// Initialize PostgreSQL database connection
	dbConn, err := sql.Open("postgres", dbURL)
	if err != nil {
		sugar.Fatalf("Failed to connect to the database: %v", err)
	}

	// Initialize sqlc queries
	queries := db.New(dbConn)

	// Initialize the REST server
	router := gin.Default()

	sugar.Infof("Initialization complete")
	return router, queries, sugar, redisClient
}
