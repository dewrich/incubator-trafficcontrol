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

// CDNs gets an array of CDNs
func (to *Session) CDNs() ([]tostructs.CDN, error) {
	url := "/api/1.2/cdns.json"
	resp, err := to.request("GET", url, nil)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var data tostructs.CDNsResponse
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}
	return data.Response, nil
}

// CDNName gets an array of CDNs
func (to *Session) CDNName(name string) ([]tostructs.CDN, error) {
	url := fmt.Sprintf("/api/1.2/cdns/name/%s.json", name)
	resp, err := to.request("GET", url, nil)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var data tostructs.CDNsResponse
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}

	return data.Response, nil
}
