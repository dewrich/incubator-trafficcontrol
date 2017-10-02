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

package client

import (
	"encoding/json"
	"fmt"

	toapi "github.com/apache/incubator-trafficcontrol/traffic_ops/api"
)

// TrafficMonitorConfigMap ...
func (to *Session) TrafficMonitorConfigMap(cdn string) (*toapi.TrafficMonitorConfigMap, error) {
	tmConfig, err := to.TrafficMonitorConfig(cdn)
	if err != nil {
		return nil, err
	}
	tmConfigMap, err := trafficMonitorTransformToMap(tmConfig)
	if err != nil {
		return nil, err
	}
	return tmConfigMap, nil
}

// TrafficMonitorConfig ...
func (to *Session) TrafficMonitorConfig(cdn string) (*toapi.TrafficMonitorConfig, error) {
	url := fmt.Sprintf("/api/1.2/cdns/%s/configs/monitoring.json", cdn)
	resp, err := to.request("GET", url, nil)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var data toapi.TMConfigResponse
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}

	return &data.Response, nil
}

func trafficMonitorTransformToMap(tmConfig *toapi.TrafficMonitorConfig) (*toapi.TrafficMonitorConfigMap, error) {
	var tm toapi.TrafficMonitorConfigMap

	tm.TrafficServer = make(map[string]toapi.TrafficServer)
	tm.CacheGroup = make(map[string]toapi.TMCacheGroup)
	tm.Config = make(map[string]interface{})
	tm.TrafficMonitor = make(map[string]toapi.TrafficMonitor)
	tm.DeliveryService = make(map[string]toapi.TMDeliveryService)
	tm.Profile = make(map[string]toapi.TMProfile)

	for _, trafficServer := range tmConfig.TrafficServers {
		tm.TrafficServer[trafficServer.HostName] = trafficServer
	}

	for _, cacheGroup := range tmConfig.CacheGroups {
		tm.CacheGroup[cacheGroup.Name] = cacheGroup
	}

	for parameterKey, parameterVal := range tmConfig.Config {
		tm.Config[parameterKey] = parameterVal
	}

	for _, trafficMonitor := range tmConfig.TrafficMonitors {
		tm.TrafficMonitor[trafficMonitor.HostName] = trafficMonitor
	}

	for _, deliveryService := range tmConfig.DeliveryServices {
		tm.DeliveryService[deliveryService.XMLID] = deliveryService
	}

	for _, profile := range tmConfig.Profiles {
		bwThreshold := profile.Parameters.Thresholds["availableBandwidthInKbps"]
		profile.Parameters.MinFreeKbps = int64(bwThreshold.Val)
		tm.Profile[profile.Name] = profile
	}

	return &tm, nil
}
