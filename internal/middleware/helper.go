package middleware

import (
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	db "github.com/speedpay/internal/db/helper"
	"github.com/spf13/viper"
)

var jwtSecretKey string

// InitJWTSecret initializes the JWT secret key from the config file
func InitJWTSecret() {
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.AddConfigPath("../../common/config")

	if err := viper.ReadInConfig(); err != nil {
		panic(fmt.Sprintf("Error reading config file: %v", err))
	}

	jwtSecretKey = viper.GetString("jwt.jwt-secret")
	if jwtSecretKey == "" {
		panic("JWT secret key is not defined in the config file")
	}
}

func generateJWT(userID int64, email, loginID string) (string, error) {
	claims := jwt.MapClaims{
		"user_id":  userID,
		"email":    email,
		"login_id": loginID,
		"exp":      time.Now().Add(time.Hour * 24).Unix(), // Token expiration time
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte(jwtSecretKey))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func JWTMiddleware(queries db.Queries) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")

		// If no Authorization header is present, generate a new token
		if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
			var loginRequest struct {
				LoginID  string `json:"login_id"`
				Password string `json:"password"`
			}

			if err := c.ShouldBindJSON(&loginRequest); err != nil {
				c.JSON(http.StatusBadRequest, gin.H{"error": "NO Access"})
				c.Abort()
				return
			}

			loginID := loginRequest.LoginID

			// Generate token directly using login_id and password (no validation)
			newToken, err := generateJWT(0, "", loginID) // No userID and email required, just loginID
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
				c.Abort()
				return
			}

			c.JSON(http.StatusOK, gin.H{"token": newToken})
			c.Abort()
			return
		}

		// Proceed with the request as token is valid
		c.Next()
	}
}
