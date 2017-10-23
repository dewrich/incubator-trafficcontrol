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
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/url"

	log "github.com/apache/incubator-trafficcontrol/lib/go-log"
)

// Config reflects the structure of the cdn.conf file
type Config struct {
	URL                *url.URL       `json:"-"`
	DB                 ConfigDatabase `json:"db"`
	Port               string         `json:"port"`
	LogLocationError   string         `json:"log_location_error"`
	LogLocationWarning string         `json:"log_location_warning"`
	LogLocationInfo    string         `json:"log_location_info"`
	LogLocationDebug   string         `json:"log_location_debug"`
	LogLocationEvent   string         `json:"log_location_event"`
	Insecure           bool           `json:"insecure"`
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

// LoadConfig - reads the config file into the Config struct
func LoadConfig(cdnConfPath string, dbConfPath string) (Config, error) {
	// load json from cdn.conf
	confBytes, err := ioutil.ReadFile(cdnConfPath)
	if err != nil {
		return Config{}, fmt.Errorf("reading CDN conf '%s': %v", cdnConfPath, err)
	}

	var cfg Config
	err = json.Unmarshal(confBytes, &cfg)
	if err != nil {
		return Config{}, fmt.Errorf("unmarshalling '%s': %v", cdnConfPath, err)
	}

	// load json from database.conf
	dbConfBytes, err := ioutil.ReadFile(dbConfPath)
	if err != nil {
		return Config{}, fmt.Errorf("reading db conf '%s': %v", dbConfPath, err)
	}
	err = json.Unmarshal(dbConfBytes, &cfg.DB)
	if err != nil {
		return Config{}, fmt.Errorf("unmarshalling '%s': %v", dbConfPath, err)
	}
	cfg, err = ParseConfig(cfg)

	return cfg, err
}

// ParseConfig validates required fields, and parses non-JSON types
func ParseConfig(cfg Config) (Config, error) {
	missings := ""
	if cfg.Port == "" {
		missings += "port, "
	}
	if cfg.LogLocationError == "" {
		cfg.LogLocationError = log.LogLocationNull
	}
	if cfg.LogLocationWarning == "" {
		cfg.LogLocationWarning = log.LogLocationNull
	}
	if cfg.LogLocationInfo == "" {
		cfg.LogLocationInfo = log.LogLocationNull
	}
	if cfg.LogLocationDebug == "" {
		cfg.LogLocationDebug = log.LogLocationNull
	}
	if cfg.LogLocationEvent == "" {
		cfg.LogLocationEvent = log.LogLocationNull
	}

	return cfg, nil
}
