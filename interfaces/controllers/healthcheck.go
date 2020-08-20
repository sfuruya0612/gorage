package controllers

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func HealthCheck(c *gin.Context) {
	fmt.Println(c.Cookie("domain"))
	c.JSON(200, gin.H{
		"message": "OK",
	})
}
