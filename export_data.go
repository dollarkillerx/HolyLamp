package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"time"

	"github.com/dollarkillerx/HolyLamp/utils"
)

func main() {
	var jData JData
	jDataBytes, err := ioutil.ReadFile("golden_data.json")
	if err != nil {
		panic(err)
	}

	err = json.Unmarshal(jDataBytes, &jData)
	if err != nil {
		panic(err)
	}

	db, err := utils.InitPostgres()
	if err != nil {
		panic(err)
	}

	db.AutoMigrate(&Item{})

	var its []Item
	for _, v := range jData.Data.Items {
		v.OpenTimeStr = time.Unix(v.OpenTime, 0).Format("2006-01-02 15:04:05")
		v.CloseTimeStr = time.Unix(v.CloseTime, 0).Format("2006-01-02 15:04:05")
		its = append(its, v)
	}

	err = db.Model(&Item{}).CreateInBatches(its, 100).Error
	if err != nil {
		panic(err)
	}

	fmt.Println("success")
}

type JData struct {
	Code int `json:"code"`
	Data struct {
		Total          int     `json:"Total"`
		TotalLots      float64 `json:"TotalLots"`
		TotalProfit    float64 `json:"TotalProfit"`
		Items          []Item  `json:"Items"`
		IsHiding       bool    `json:"IsHiding"`
		HasSubscribed  bool    `json:"HasSubscribed"`
		BrokerTimeZone int     `json:"BrokerTimeZone"`
	} `json:"data"`
	Message string `json:"message"`
}

type Item struct {
	ID           int     `gorm:"primarykey" json:"ID"`
	Cmd          int     `gorm:"index" json:"Cmd,omitempty"` // cmd 0 buy, cmd 1 sell
	TradeID      int     `json:"TradeID"`
	Symbol       string  `gorm:"index" json:"Symbol"`
	Digits       int     `json:"Digits"`
	Volume       float64 `gorm:"type:NUMERIC(20,7)" json:"Volume"`
	OpenTime     int64   `json:"OpenTime"`
	CloseTime    int64   `json:"CloseTime"`
	OpenTimeStr  string  `json:"open_time_str"`  // ins
	CloseTimeStr string  `json:"close_time_str"` // ins
	OpenPrice    float64 `gorm:"type:NUMERIC(20,7)" json:"OpenPrice"`
	ClosePrice   float64 `gorm:"type:NUMERIC(20,7)" json:"ClosePrice"`
	TP           float64 `gorm:"type:NUMERIC(20,7)" json:"TP,omitempty"`
	Profit       float64 `gorm:"type:NUMERIC(20,7)" json:"Profit,omitempty"`
	Swap         float64 `gorm:"type:NUMERIC(20,7)" json:"Swap,omitempty"`
	SL           float64 `gorm:"type:NUMERIC(20,7)" json:"SL,omitempty"`
}
