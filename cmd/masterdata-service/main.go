package main

import (
	"context"
	"log"
	"os"

	"database/sql"
	"github.com/speedpay/cmd/masterdata-service/pkg/db"
	"github.com/gin-gonic/gin"

	"github.com/speedpay/rest"

	"github.com/go-redis/redis/v8" // Redis client
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
	redisAddr := os.Getenv("REDIS_ADDR")
	redisPass := os.Getenv("REDIS_PASS")
	port := os.Getenv("PORT")

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
	defer dbConn.Close()

	// Initialize sqlc queries
	queries := db.New(dbConn)

	// Initialize the REST server
	router := gin.Default()

	rest.NewServer(queries, sugar, redisClient).RegisterRoutes(router)

	// Register routes and start the Gin server
	sugar.Infof("Starting server on port %s", port)
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}
}
