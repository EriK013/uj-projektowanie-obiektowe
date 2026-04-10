package main

import (
    "zadanie4/controllers"
    "github.com/labstack/echo/v4"
)

func main() {
    e := echo.New()

    e.GET("/weather", controllers.GetWeather)
    e.POST("/weather", controllers.GetWeather)

    e.Start(":8080")
}