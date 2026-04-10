package controllers

import (
	"net/http"
	"zadanie4/database"
	"zadanie4/models"
    "zadanie4/proxy"
	"github.com/labstack/echo/v4"
)

func GetWeather(c echo.Context) error {
	 p := proxy.WeatherProxy{}
    weather, err := p.GetCurrentWeather()
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Błąd pobierania danych",
        })
    }
    return c.JSON(http.StatusOK, weather)
}

func GetWeatherDB(c echo.Context) error {
	var weather []models.Weather
	database.DB.Find(&weather)
    return c.JSON(http.StatusOK, weather)
}