package main

import (
    "zadanie4/controllers"
	"zadanie4/database"
    "github.com/labstack/echo/v4"
)

func main() {
	database.InitDB()
    e := echo.New()

    e.GET("/weather", controllers.GetWeather)
	e.GET("/weather/db", controllers.GetWeatherDB)
    e.POST("/weather", controllers.GetWeather)

    e.Start(":8080")
}