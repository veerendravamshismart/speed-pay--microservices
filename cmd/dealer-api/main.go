package main

import (
	"os"

	"github.com/speedpay/rest"
	"github.com/speedpay/cmd/masterdata-service/pkg/routes"
)

func main() {
	// Initialize shared components
	router, queries, sugar, redisClient := rest.Init()

	// Create a route group for this microservice
	masterDataGroup := router.Group("/master-data")

	// Register microservice-specific routes under the "/master-data" prefix
	routes.RegisterRoutes(masterDataGroup, queries, sugar, redisClient)

	// Start the server
	port := "8080" // Default port (can be overridden in .env)
	if p := os.Getenv("PORT"); p != "" {
		port = p
	}
	sugar.Infof("Starting server on port %s", port)
	if err := router.Run(":" + port); err != nil {
		sugar.Fatalf("Failed to start server: %v", err)
	}
}
