package main

import (
	"context"
	"log"

	"database/sql"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8" // Redis/Dragonfly client
	"github.com/spf13/viper"
	_ "github.com/lib/pq"
	db "github.com/speedpay/internal/db/operator"
	rest "github.com/speedpay/internal/rest/operator"
	"go.uber.org/zap"
)

func main() {
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

	// Initialize Redis (Dragonfly) client
	redisClient := redis.NewClient(&redis.Options{
		Addr:     redisAddr,
		Password: redisPass, // No password for Redis if empty
	})

	// Test connection to Dragonfly (Redis-compatible)
	_, err := redisClient.Ping(context.Background()).Result()
	if err != nil {
		sugar.Fatalf("Failed to connect to Dragonfly server (Redis client): %v", err)
	}
	sugar.Info("Successfully connected to Dragonfly server")

	// Initialize PostgreSQL database connection
	dbConn, err := sql.Open("postgres", dbURL)
	if err != nil {
		sugar.Fatalf("Failed to connect to the database: %v", err)
	}
	defer dbConn.Close()

	// Initialize sqlc queries
	queries := db.New(dbConn)

	// Initialize Gin router
	router := gin.Default()

	// Register routes in the controller
	rest.NewOperatorController(queries, sugar, redisClient).RegisterRoutes(router)

	// Start the Gin server
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}
}
