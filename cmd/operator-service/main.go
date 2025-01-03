package main

import (
	"context"
	"log"
	"os"

	"database/sql"

	"github.com/speedpay/rest"
	"github.com/speedpay/cmd/operator-service/pkg/operator"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8" // Redis/Dragonfly client
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"go.uber.org/zap"
)

func main() {
	// Load environment variables from .env file
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found. Falling back to system environment variables.")
	}

	// Get environment variables
	dbURL := os.Getenv("DATABASE_URL")
	redisAddr := os.Getenv("REDIS_ADDR") // Dragonfly server address, could be localhost:6379
	redisPass := os.Getenv("REDIS_PASS") // Dragonfly password (if needed)
	port := os.Getenv("PORT")

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
	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		sugar.Fatalf("Failed to connect to the database: %v", err)
	}
	defer db.Close()

	// Initialize sqlc queries
	queries := operator.New(db)

	// Initialize Gin router
	router := gin.Default()

	// Register routes in the controller
	rest.NewOperatorController(queries, sugar, redisClient).RegisterRoutes(router)

	// Start the Gin server
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}
}
