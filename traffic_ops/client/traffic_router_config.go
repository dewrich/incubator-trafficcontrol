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

	tc "github.com/apache/incubator-trafficcontrol/lib/go-tc"
)

// TrafficRouterConfig Deprecated: use GetTrafficRouterConfig instead.
func (to *Session) TrafficRouterConfig(cdn string) (*tc.TrafficRouterConfig, error) {
	cfg, _, err := to.GetTrafficRouterConfig(cdn)
	return cfg, err
}

// GetTrafficRouterConfig gets the json arrays
func (to *Session) GetTrafficRouterConfig(cdn string) (*tc.TrafficRouterConfig, CacheHitStatus, error) {
	url := fmt.Sprintf("/api/1.2/cdns/%s/configs/routing.json", cdn)
	body, cacheHitStatus, err := to.getBytesWithTTL(url, tmPollingInterval)
	if err != nil {
		return nil, CacheHitStatusInvalid, err
	}

	var data tc.TRConfigResponse
	if err := json.Unmarshal(body, &data); err != nil {
		return nil, CacheHitStatusInvalid, err
	}
	return &data.Response, cacheHitStatus, nil
}
