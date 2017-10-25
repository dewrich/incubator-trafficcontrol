/*
   Copyright 2015 Comcast Cable Communications Management, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package client_tests

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/url"

	log "github.com/apache/incubator-trafficcontrol/lib/go-log"
)

var (
	db *sql.DB
)

// Config reflects the structure of the cdn.conf file
type Config struct {
	URL      *url.URL       `json:"-"`
	DB       ConfigDatabase `json:"database"`
	Port     string         `json:"port"`
	Log      Locations      `json:"logLocations"`
	Insecure bool           `json:"insecure"`
}

// ConfigDatabase reflects the structure of the database.conf file
type ConfigDatabase struct {
	Description string `json:"description"`
	DBName      string `json:"dbname"`
	Hostname    string `json:"hostname"`
	User        string `json:"user"`
	Password    string `json:"password"`
	Port        string `json:"port"`
	Type        string `json:"type"`
	SSL         bool   `json:"ssl"`
}

// ConfigDatabase reflects the structure of the database.conf file
type Locations struct {
	Debug   string `json:"debug"`
	Event   string `json:"event"`
	Error   string `json:"error"`
	Info    string `json:"info"`
	Warning string `json:"warning"`
}

// ParseConfig validates required fields, and parses non-JSON types
func ParseConfig(cfg Config) (Config, error) {
	if cfg.Log.Error == "" {
		cfg.Log.Error = log.LogLocationNull
	}
	if cfg.Log.Warning == "" {
		cfg.Log.Warning = log.LogLocationNull
	}
	if cfg.Log.Info == "" {
		cfg.Log.Info = log.LogLocationNull
	}
	if cfg.Log.Debug == "" {
		cfg.Log.Debug = log.LogLocationNull
	}
	if cfg.Log.Event == "" {
		cfg.Log.Event = log.LogLocationNull
	}
	return cfg, nil
}

// LoadConfig - reads the config file into the Config struct
func LoadConfig(confPath string) (Config, error) {
	fmt.Printf("LoadConfig...\n")
	// load json from cdn.conf
	confBytes, err := ioutil.ReadFile(confPath)
	if err != nil {
		return Config{}, fmt.Errorf("Reading CDN conf '%s': %v", confPath, err)
	}

	var cfg Config
	err = json.Unmarshal(confBytes, &cfg)
	if err != nil {
		fmt.Printf("cfg2 ---> %v\n", cfg)
		return Config{}, fmt.Errorf("unmarshalling '%s': %v", confPath, err)
	}

	cfg, err = ParseConfig(cfg)

	return cfg, err
}
