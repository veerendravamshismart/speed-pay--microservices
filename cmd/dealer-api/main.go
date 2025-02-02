package main

import (
	"context"
	"log"

	"database/sql"

	"github.com/gin-gonic/gin"
	db "github.com/speedpay/internal/db/dealer-api"
	db1 "github.com/speedpay/internal/db/helper"
	rest "github.com/speedpay/internal/rest/masterdata"

	"github.com/go-redis/redis/v8" // Redis client
	"github.com/speedpay/internal/middleware"
	"github.com/spf13/viper"

	_ "github.com/lib/pq"
	"go.uber.org/zap"
)

func main() {
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

	if port == "" {
		port = "8080" // Default port if not set
	}

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
	queries1 := db1.New(dbConn)

	// Initialize the REST server
	router := gin.Default()

	router.Use(middleware.JWTMiddleware(*queries1))

	// Register the routes based on the modified ones you wanted
	rest.NewServer(queries, sugar, redisClient).RegisterRoutes(router)

	// Register routes and start the Gin server
	sugar.Infof("Starting server on port %s", port)
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}
}
