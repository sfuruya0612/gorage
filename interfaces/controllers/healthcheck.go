package controllers

import (
	"github.com/gin-gonic/gin"
)

func HealthCheck(c *gin.Context) {
	cookie, err := c.Cookie("foo")
	if err != nil {
		cookie = "none"
		// fmt.Printf("Error: %v", err)
	}

	c.JSON(200, gin.H{
		"message": "OK",
		"cookie":  cookie,
	})
}
