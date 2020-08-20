package main

import (
	"fmt"

	"github.com/sfuruya0612/gorage/infrastructure"
)

func main() {
	if err := infrastructure.Router.Run(); err != nil {
		fmt.Printf("Error: %v", err)
	}
}
