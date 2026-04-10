package database

import (
	"zadanie4/models"
	"gorm.io/driver/sqlite"
    "gorm.io/gorm"
)

var DB *gorm.DB

func InitDB() {
	db, err := gorm.Open(sqlite.Open("zadanie4.db"), &gorm.Config{})
    if err != nil {
        panic("Nie udało się połączyć z bazą danych")
    }
    DB = db
	DB.AutoMigrate(&models.Weather{})

	db.Create(&models.Weather{City: "Krakow", Temperature: 2, WindSpeed: 1})
	db.Create(&models.Weather{City: "Warszawa", Temperature: 3, WindSpeed: 7})
}
