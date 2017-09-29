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

	"github.com/apache/incubator-trafficcontrol/traffic_ops/tostructs"
)

// DeliveryServices gets an array of DeliveryServices
func (to *Session) DeliveryServices() ([]tostructs.DeliveryService, error) {
	var data tostructs.GetDeliveryServiceResponse
	err := get(to, deliveryServicesEp(), &data)
	if err != nil {
		return nil, err
	}

	return data.Response, nil
}

// DeliveryService gets the DeliveryService for the ID it's passed
func (to *Session) DeliveryService(id string) (*tostructs.DeliveryService, error) {
	var data tostructs.GetDeliveryServiceResponse
	err := get(to, deliveryServiceEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response[0], nil
}

// CreateDeliveryService creates the DeliveryService it's passed
func (to *Session) CreateDeliveryService(ds *tostructs.DeliveryService) (*tostructs.CreateDeliveryServiceResponse, error) {
	var data tostructs.CreateDeliveryServiceResponse
	jsonReq, err := json.Marshal(ds)
	if err != nil {
		return nil, err
	}
	err = post(to, deliveryServicesEp(), jsonReq, &data)
	if err != nil {
		return nil, err
	}

	return &data, nil
}

// UpdateDeliveryService updates the DeliveryService matching the ID it's passed with
// the DeliveryService it is passed
func (to *Session) UpdateDeliveryService(id string, ds *tostructs.DeliveryService) (*tostructs.UpdateDeliveryServiceResponse, error) {
	var data tostructs.UpdateDeliveryServiceResponse
	jsonReq, err := json.Marshal(ds)
	if err != nil {
		return nil, err
	}
	err = put(to, deliveryServiceEp(id), jsonReq, &data)
	if err != nil {
		return nil, err
	}

	return &data, nil
}

// DeleteDeliveryService deletes the DeliveryService matching the ID it's passed
func (to *Session) DeleteDeliveryService(id string) (*tostructs.DeleteDeliveryServiceResponse, error) {
	var data tostructs.DeleteDeliveryServiceResponse
	err := del(to, deliveryServiceEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data, nil
}

// DeliveryServiceState gets the DeliveryServiceState for the ID it's passed
func (to *Session) DeliveryServiceState(id string) (*tostructs.DeliveryServiceState, error) {
	var data tostructs.DeliveryServiceStateResponse
	err := get(to, deliveryServiceStateEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

// DeliveryServiceHealth gets the DeliveryServiceHealth for the ID it's passed
func (to *Session) DeliveryServiceHealth(id string) (*tostructs.DeliveryServiceHealth, error) {
	var data tostructs.DeliveryServiceHealthResponse
	err := get(to, deliveryServiceHealthEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

// DeliveryServiceCapacity gets the DeliveryServiceCapacity for the ID it's passed
func (to *Session) DeliveryServiceCapacity(id string) (*tostructs.DeliveryServiceCapacity, error) {
	var data tostructs.DeliveryServiceCapacityResponse
	err := get(to, deliveryServiceCapacityEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

// DeliveryServiceRouting gets the DeliveryServiceRouting for the ID it's passed
func (to *Session) DeliveryServiceRouting(id string) (*tostructs.DeliveryServiceRouting, error) {
	var data tostructs.DeliveryServiceRoutingResponse
	err := get(to, deliveryServiceRoutingEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

// DeliveryServiceServer gets the DeliveryServiceServer
func (to *Session) DeliveryServiceServer(page, limit string) ([]tostructs.DeliveryServiceServer, error) {
	var data tostructs.DeliveryServiceServerResponse
	err := get(to, deliveryServiceServerEp(page, limit), &data)
	if err != nil {
		return nil, err
	}

	return data.Response, nil
}

// DeliveryServiceSSLKeysByID gets the DeliveryServiceSSLKeys by ID
func (to *Session) DeliveryServiceSSLKeysByID(id string) (*tostructs.DeliveryServiceSSLKeys, error) {
	var data tostructs.DeliveryServiceSSLKeysResponse
	err := get(to, deliveryServiceSSLKeysByIDEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

// DeliveryServiceSSLKeysByHostname gets the DeliveryServiceSSLKeys by Hostname
func (to *Session) DeliveryServiceSSLKeysByHostname(hostname string) (*tostructs.DeliveryServiceSSLKeys, error) {
	var data tostructs.DeliveryServiceSSLKeysResponse
	err := get(to, deliveryServiceSSLKeysByHostnameEp(hostname), &data)
	if err != nil {
		return nil, err
	}

	return &data.Response, nil
}

func get(to *Session, endpoint string, respStruct interface{}) error {
	return makeReq(to, "GET", endpoint, nil, respStruct)
}

func post(to *Session, endpoint string, body []byte, respStruct interface{}) error {
	return makeReq(to, "POST", endpoint, body, respStruct)
}

func put(to *Session, endpoint string, body []byte, respStruct interface{}) error {
	return makeReq(to, "PUT", endpoint, body, respStruct)
}

func del(to *Session, endpoint string, respStruct interface{}) error {
	return makeReq(to, "DELETE", endpoint, nil, respStruct)
}

func makeReq(to *Session, method, endpoint string, body []byte, respStruct interface{}) error {
	resp, err := to.request(method, endpoint, body)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if err := json.NewDecoder(resp.Body).Decode(respStruct); err != nil {
		return err
	}

	return nil
}
