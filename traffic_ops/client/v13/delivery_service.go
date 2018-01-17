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

package v13

import (
	"encoding/json"
	"strconv"

	tcapi "github.com/apache/incubator-trafficcontrol/lib/go-tc/v13"
)

// DeliveryServices gets an array of DeliveryServices
// Deprecated: use GetDeliveryServices
func (to *Session) DeliveryServices() ([]tcapi.DeliveryService, error) {
	dses, _, err := to.GetDeliveryServices()
	return dses, err
}

func (to *Session) GetDeliveryServices() ([]tcapi.DeliveryService, ReqInf, error) {
	var data tcapi.GetDeliveryServiceResponse
	reqInf, err := get(to, deliveryServicesEp(), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return data.Response, reqInf, nil
}

// DeliveryServicesByServer gets an array of all DeliveryServices with the given server ID assigend.
// Deprecated: use GetDeliveryServicesByServer
func (to *Session) DeliveryServicesByServer(id int) ([]tcapi.DeliveryService, error) {
	dses, _, err := to.GetDeliveryServicesByServer(id)
	return dses, err
}

func (to *Session) GetDeliveryServicesByServer(id int) ([]tcapi.DeliveryService, ReqInf, error) {
	var data tcapi.GetDeliveryServiceResponse
	reqInf, err := get(to, deliveryServicesByServerEp(strconv.Itoa(id)), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return data.Response, reqInf, nil
}

// DeliveryService gets the DeliveryService for the ID it's passed
// Deprecated: use GetDeliveryService
func (to *Session) DeliveryService(id string) (*tcapi.DeliveryService, error) {
	ds, _, err := to.GetDeliveryService(id)
	return ds, err
}

func (to *Session) GetDeliveryService(id string) (*tcapi.DeliveryService, ReqInf, error) {
	var data tcapi.GetDeliveryServiceResponse
	reqInf, err := get(to, deliveryServiceEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response[0], reqInf, nil
}

// CreateDeliveryService creates the DeliveryService it's passed
func (to *Session) CreateDeliveryService(ds *tcapi.DeliveryService) (*tcapi.CreateDeliveryServiceResponse, error) {
	var data tcapi.CreateDeliveryServiceResponse
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
func (to *Session) UpdateDeliveryService(id string, ds *tcapi.DeliveryService) (*tcapi.UpdateDeliveryServiceResponse, error) {
	var data tcapi.UpdateDeliveryServiceResponse
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
func (to *Session) DeleteDeliveryService(id string) (*tcapi.DeleteDeliveryServiceResponse, error) {
	var data tcapi.DeleteDeliveryServiceResponse
	err := del(to, deliveryServiceEp(id), &data)
	if err != nil {
		return nil, err
	}

	return &data, nil
}

// DeliveryServiceState gets the DeliveryServiceState for the ID it's passed
// Deprecated: use GetDeliveryServiceState
func (to *Session) DeliveryServiceState(id string) (*tcapi.DeliveryServiceState, error) {
	dss, _, err := to.GetDeliveryServiceState(id)
	return dss, err
}

func (to *Session) GetDeliveryServiceState(id string) (*tcapi.DeliveryServiceState, ReqInf, error) {
	var data tcapi.DeliveryServiceStateResponse
	reqInf, err := get(to, deliveryServiceStateEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}

// DeliveryServiceHealth gets the DeliveryServiceHealth for the ID it's passed
// Deprecated: use GetDeliveryServiceHealth
func (to *Session) DeliveryServiceHealth(id string) (*tcapi.DeliveryServiceHealth, error) {
	dsh, _, err := to.GetDeliveryServiceHealth(id)
	return dsh, err
}

func (to *Session) GetDeliveryServiceHealth(id string) (*tcapi.DeliveryServiceHealth, ReqInf, error) {
	var data tcapi.DeliveryServiceHealthResponse
	reqInf, err := get(to, deliveryServiceHealthEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}

// DeliveryServiceCapacity gets the DeliveryServiceCapacity for the ID it's passed
// Deprecated: use GetDeliveryServiceCapacity
func (to *Session) DeliveryServiceCapacity(id string) (*tcapi.DeliveryServiceCapacity, error) {
	dsc, _, err := to.GetDeliveryServiceCapacity(id)
	return dsc, err
}

func (to *Session) GetDeliveryServiceCapacity(id string) (*tcapi.DeliveryServiceCapacity, ReqInf, error) {
	var data tcapi.DeliveryServiceCapacityResponse
	reqInf, err := get(to, deliveryServiceCapacityEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}

// DeliveryServiceRouting gets the DeliveryServiceRouting for the ID it's passed
// Deprecated: use GetDeliveryServiceRouting
func (to *Session) DeliveryServiceRouting(id string) (*tcapi.DeliveryServiceRouting, error) {
	dsr, _, err := to.GetDeliveryServiceRouting(id)
	return dsr, err
}

func (to *Session) GetDeliveryServiceRouting(id string) (*tcapi.DeliveryServiceRouting, ReqInf, error) {
	var data tcapi.DeliveryServiceRoutingResponse
	reqInf, err := get(to, deliveryServiceRoutingEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}

// DeliveryServiceServer gets the DeliveryServiceServer
// Deprecated: use GetDeliveryServiceServer
func (to *Session) DeliveryServiceServer(page, limit string) ([]tcapi.DeliveryServiceServer, error) {
	dss, _, err := to.GetDeliveryServiceServer(page, limit)
	return dss, err
}

func (to *Session) GetDeliveryServiceServer(page, limit string) ([]tcapi.DeliveryServiceServer, ReqInf, error) {
	var data tcapi.DeliveryServiceServerResponse
	reqInf, err := get(to, deliveryServiceServerEp(page, limit), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return data.Response, reqInf, nil
}

// DeliveryServiceRegexes gets the DeliveryService regexes
// Deprecated: use GetDeliveryServiceRegexes
func (to *Session) DeliveryServiceRegexes() ([]tcapi.DeliveryServiceRegexes, error) {
	dsrs, _, err := to.GetDeliveryServiceRegexes()
	return dsrs, err
}
func (to *Session) GetDeliveryServiceRegexes() ([]tcapi.DeliveryServiceRegexes, ReqInf, error) {
	var data tcapi.DeliveryServiceRegexResponse
	reqInf, err := get(to, deliveryServiceRegexesEp(), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return data.Response, reqInf, nil
}

// DeliveryServiceSSLKeysByID gets the DeliveryServiceSSLKeys by ID
// Deprecated: use GetDeliveryServiceSSLKeysByID
func (to *Session) DeliveryServiceSSLKeysByID(id string) (*tcapi.DeliveryServiceSSLKeys, error) {
	dsks, _, err := to.GetDeliveryServiceSSLKeysByID(id)
	return dsks, err
}

func (to *Session) GetDeliveryServiceSSLKeysByID(id string) (*tcapi.DeliveryServiceSSLKeys, ReqInf, error) {
	var data tcapi.DeliveryServiceSSLKeysResponse
	reqInf, err := get(to, deliveryServiceSSLKeysByIDEp(id), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}

// DeliveryServiceSSLKeysByHostname gets the DeliveryServiceSSLKeys by Hostname
// Deprecated: use GetDeliveryServiceSSLKeysByHostname
func (to *Session) DeliveryServiceSSLKeysByHostname(hostname string) (*tcapi.DeliveryServiceSSLKeys, error) {
	dsks, _, err := to.GetDeliveryServiceSSLKeysByHostname(hostname)
	return dsks, err
}

func (to *Session) GetDeliveryServiceSSLKeysByHostname(hostname string) (*tcapi.DeliveryServiceSSLKeys, ReqInf, error) {
	var data tcapi.DeliveryServiceSSLKeysResponse
	reqInf, err := get(to, deliveryServiceSSLKeysByHostnameEp(hostname), &data)
	if err != nil {
		return nil, reqInf, err
	}

	return &data.Response, reqInf, nil
}
