package main

import (
	"context"
	"log"

	"database/sql"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	db "github.com/speedpay/internal/db/productcontroller"
	rest "github.com/speedpay/internal/rest/productController"
	"github.com/spf13/viper"
	"go.uber.org/zap"

	_ "github.com/lib/pq" // Import PostgreSQL driver
	"github.com/speedpay/internal/middleware"
)

func main() {
	middleware.InitJWTSecret()
	// Load configuration from config.yaml
	viper.SetConfigName("config")              // Name of the config file without extension
	viper.SetConfigType("yaml")                // Specify the file type
	viper.AddConfigPath("../../common/config") // Path to look for the config file

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

	rest.NewServer(queries, sugar, redisClient).RegisterRoutes(router)

	// Start the Gin server
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}

}
