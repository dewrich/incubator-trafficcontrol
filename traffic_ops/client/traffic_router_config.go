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

	"github.com/apache/incubator-trafficcontrol/traffic_ops/tostructs"
)

// TrafficRouterConfigMap Deprecated: use GetTrafficRouterConfigMap instead.
func (to *Session) TrafficRouterConfigMap(cdn string) (*tostructs.TrafficRouterConfigMap, error) {
	cfg, _, err := to.GetTrafficRouterConfigMap(cdn)
	return cfg, err
}

// TrafficRouterConfigMap gets a bunch of maps
func (to *Session) GetTrafficRouterConfigMap(cdn string) (*tostructs.TrafficRouterConfigMap, CacheHitStatus, error) {
	trConfig, cacheHitStatus, err := to.GetTrafficRouterConfig(cdn)
	if err != nil {
		return nil, CacheHitStatusInvalid, err
	}

	trConfigMap := TRTransformToMap(*trConfig)
	return &trConfigMap, cacheHitStatus, nil
}

// TrafficRouterConfig Deprecated: use GetTrafficRouterConfig instead.
func (to *Session) TrafficRouterConfig(cdn string) (*tostructs.TrafficRouterConfig, error) {
	cfg, _, err := to.GetTrafficRouterConfig(cdn)
	return cfg, err
}

// GetTrafficRouterConfig gets the json arrays
func (to *Session) GetTrafficRouterConfig(cdn string) (*tostructs.TrafficRouterConfig, CacheHitStatus, error) {
	url := fmt.Sprintf("/api/1.2/cdns/%s/configs/routing.json", cdn)
	body, cacheHitStatus, err := to.getBytesWithTTL(url, tmPollingInterval)
	if err != nil {
		return nil, CacheHitStatusInvalid, err
	}

	var data tostructs.TRConfigResponse
	if err := json.Unmarshal(body, &data); err != nil {
		return nil, CacheHitStatusInvalid, err
	}
	return &data.Response, cacheHitStatus, nil
}

// TRTransformToMap ...
func TRTransformToMap(trConfig tostructs.TrafficRouterConfig) tostructs.TrafficRouterConfigMap {
	var tr tostructs.TrafficRouterConfigMap
	tr.TrafficServer = make(map[string]tostructs.TrafficServer)
	tr.TrafficMonitor = make(map[string]tostructs.TrafficMonitor)
	tr.TrafficRouter = make(map[string]tostructs.TrafficRouter)
	tr.CacheGroup = make(map[string]tostructs.TMCacheGroup)
	tr.DeliveryService = make(map[string]tostructs.TRDeliveryService)
	tr.Config = make(map[string]interface{})
	tr.Stat = make(map[string]interface{})

	for _, trServer := range trConfig.TrafficServers {
		tr.TrafficServer[trServer.HostName] = trServer
	}
	for _, trMonitor := range trConfig.TrafficMonitors {
		tr.TrafficMonitor[trMonitor.HostName] = trMonitor
	}
	for _, trServer := range trConfig.TrafficServers {
		tr.TrafficServer[trServer.HostName] = trServer
	}
	for _, trRouter := range trConfig.TrafficRouters {
		tr.TrafficRouter[trRouter.FQDN] = trRouter
	}
	for _, trCacheGroup := range trConfig.CacheGroups {
		tr.CacheGroup[trCacheGroup.Name] = trCacheGroup
	}
	for _, trDeliveryService := range trConfig.DeliveryServices {
		tr.DeliveryService[trDeliveryService.XMLID] = trDeliveryService
	}
	for trSettingKey, trSettingVal := range trConfig.Config {
		tr.Config[trSettingKey] = trSettingVal
	}
	for trStatKey, trStatVal := range trConfig.Stats {
		tr.Stat[trStatKey] = trStatVal
	}
	return tr
}
