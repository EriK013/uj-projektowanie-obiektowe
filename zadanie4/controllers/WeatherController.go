package controllers

import (
	"net/http"
	"io"
	"encoding/json"
	"zadanie4/database"
	"zadanie4/models"
	"github.com/labstack/echo/v4"
)

type Weather struct {
	Temperature float64 `json:"temperature_2m"`
	WindSpeed   float64 `json:"wind_speed_10m"`
}

type ApiResponse struct {
	CurrentWeather Weather `json:"current"`
}

func GetWeather(c echo.Context) error {
	url := "https://api.open-meteo.com/v1/forecast" +
        "?latitude=50.0614&longitude=19.9366" +
        "&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code"

    resp, err := http.Get(url)
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Nie udało się połączyć z API",
        })
    }
    defer resp.Body.Close()

    body, err := io.ReadAll(resp.Body)
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Błąd odczytu odpowiedzi",
        })
    }

    var meteoData ApiResponse
    if err := json.Unmarshal(body, &meteoData); err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Błąd parsowania JSON",
        })
    }

    return c.JSON(http.StatusOK, meteoData)
}

func GetWeatherDB(c echo.Context) error {
	var weather []models.Weather
	database.DB.Find(&weather)
    return c.JSON(http.StatusOK, weather)
}