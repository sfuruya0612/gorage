package infrastructure

import (
	"github.com/gin-gonic/gin"

	"github.com/sfuruya0612/gorage/interfaces/controllers"
)

var Router *gin.Engine

func init() {
	router := gin.Default()

	// healthcheck path
	router.GET("/api/healthcheck", func(c *gin.Context) { controllers.HealthCheck(c) })

	// router.GET("/api/objects", func(c *gin.Context) { controllers.Index(c) })
	// router.POST("/api/object/upload", func(c *gin.Context) { userController.upload(c) })
	// router.POST("/api/object/download", func(c *gin.Context) { userController.download(c) })
	// router.DELETE("/api/object/remove", func(c *gin.Context) { userController.remove(c) })

	Router = router
}
