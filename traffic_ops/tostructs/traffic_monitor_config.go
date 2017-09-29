package tostructs

import (
	"encoding/json"
	"fmt"
	"strconv"
	"strings"
)

/*

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

// TMConfigResponse ...
type TMConfigResponse struct {
	Response TrafficMonitorConfig `json:"response"`
}

// TrafficMonitorConfig ...
type TrafficMonitorConfig struct {
	TrafficServers   []TrafficServer        `json:"trafficServers,omitempty"`
	CacheGroups      []TMCacheGroup         `json:"cacheGroups,omitempty"`
	Config           map[string]interface{} `json:"config,omitempty"`
	TrafficMonitors  []TrafficMonitor       `json:"trafficMonitors,omitempty"`
	DeliveryServices []TMDeliveryService    `json:"deliveryServices,omitempty"`
	Profiles         []TMProfile            `json:"profiles,omitempty"`
}

// TrafficMonitorConfigMap ...
type TrafficMonitorConfigMap struct {
	TrafficServer   map[string]TrafficServer
	CacheGroup      map[string]TMCacheGroup
	Config          map[string]interface{}
	TrafficMonitor  map[string]TrafficMonitor
	DeliveryService map[string]TMDeliveryService
	Profile         map[string]TMProfile
}

// TrafficMonitor ...
type TrafficMonitor struct {
	Port     int    `json:"port"`
	IP6      string `json:"ip6"`
	IP       string `json:"ip"`
	HostName string `json:"hostName"`
	FQDN     string `json:"fqdn"`
	Profile  string `json:"profile"`
	Location string `json:"location"`
	Status   string `json:"status"`
}

// TMDeliveryService ...
type TMDeliveryService struct {
	XMLID              string `json:"xmlId"`
	TotalTPSThreshold  int64  `json:"TotalTpsThreshold"`
	Status             string `json:"status"`
	TotalKbpsThreshold int64  `json:"TotalKbpsThreshold"`
}

// TMProfile ...
type TMProfile struct {
	Parameters TMParameters `json:"parameters"`
	Name       string       `json:"name"`
	Type       string       `json:"type"`
}

// TMParameters ...
// TODO change TO to return this struct, so a custom UnmarshalJSON isn't necessary.
type TMParameters struct {
	HealthConnectionTimeout int    `json:"health.connection.timeout"`
	HealthPollingURL        string `json:"health.polling.url"`
	HistoryCount            int    `json:"history.count"`
	MinFreeKbps             int64
	Thresholds              map[string]HealthThreshold `json:"health_threshold"`
}

func (params *TMParameters) UnmarshalJSON(bytes []byte) (err error) {
	raw := map[string]interface{}{}
	if err := json.Unmarshal(bytes, &raw); err != nil {
		return err
	}

	if vi, ok := raw["health.connection.timeout"]; ok {
		if v, ok := vi.(float64); !ok {
			return fmt.Errorf("Unmarshalling TMParameters health.connection.timeout expected integer, got %v", vi)
		} else {
			params.HealthConnectionTimeout = int(v)
		}
	}

	if vi, ok := raw["health.polling.url"]; ok {
		if v, ok := vi.(string); !ok {
			return fmt.Errorf("Unmarshalling TMParameters health.polling.url expected string, got %v", vi)
		} else {
			params.HealthPollingURL = v
		}
	}

	if vi, ok := raw["history.count"]; ok {
		if v, ok := vi.(float64); !ok {
			return fmt.Errorf("Unmarshalling TMParameters history.count expected integer, got %v", vi)
		} else {
			params.HistoryCount = int(v)
		}
	}

	params.Thresholds = map[string]HealthThreshold{}
	thresholdPrefix := "health.threshold."
	for k, v := range raw {
		if strings.HasPrefix(k, thresholdPrefix) {
			stat := k[len(thresholdPrefix):]
			vStr := fmt.Sprintf("%v", v) // allows string or numeric JSON types. TODO check if a type switch is faster.
			if t, err := strToThreshold(vStr); err != nil {
				return fmt.Errorf("Unmarshalling TMParameters `health.threshold.` parameter value not of the form `(>|)(=|)\\d+`: stat '%s' value '%v'", k, v)
			} else {
				params.Thresholds[stat] = t
			}
		}
	}
	return nil
}

const DefaultHealthThresholdComparator = "<"

// strToThreshold takes a string like ">=42" and returns a HealthThreshold with a Val of `42` and a Comparator of `">="`. If no comparator exists, `DefaultHealthThresholdComparator` is used. If the string is not of the form "(>|<|)(=|)\d+" an error is returned
func strToThreshold(s string) (HealthThreshold, error) {
	comparators := []string{"=", ">", "<", ">=", "<="}
	for _, comparator := range comparators {
		if strings.HasPrefix(s, comparator) {
			valStr := s[len(comparator):]
			val, err := strconv.ParseFloat(valStr, 64)
			if err != nil {
				return HealthThreshold{}, fmt.Errorf("invalid threshold: NaN")
			}
			return HealthThreshold{Val: val, Comparator: comparator}, nil
		}
	}
	val, err := strconv.ParseFloat(s, 64)
	if err != nil {
		return HealthThreshold{}, fmt.Errorf("invalid threshold: NaN")
	}
	return HealthThreshold{Val: val, Comparator: DefaultHealthThresholdComparator}, nil
}

type HealthThreshold struct {
	Val        float64
	Comparator string // TODO change to enum?
}
