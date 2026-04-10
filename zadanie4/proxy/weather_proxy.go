package proxy

import (
	"encoding/json"
	"io"
	"net/http"
)

type Weather struct {
	Temperature float64 `json:"temperature_2m"`
	WindSpeed   float64 `json:"wind_speed_10m"`
}

type ApiResponse struct {
	Current Weather `json:"current"`
}

type WeatherProxy struct{}

func (p *WeatherProxy) GetCurrentWeather() (*Weather, error) {
    url := "https://api.open-meteo.com/v1/forecast" +
        "?latitude=50.0614&longitude=19.9366" +
        "&current=temperature_2m,wind_speed_10m"

    resp, err := http.Get(url)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()

    body, err := io.ReadAll(resp.Body)
    if err != nil {
        return nil, err
    }

    var data ApiResponse
    if err := json.Unmarshal(body, &data); err != nil {
        return nil, err
    }

    return &data.Current, nil
}