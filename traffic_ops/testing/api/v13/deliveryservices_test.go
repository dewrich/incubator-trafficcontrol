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
	"testing"

	"github.com/apache/incubator-trafficcontrol/lib/go-log"
	tc "github.com/apache/incubator-trafficcontrol/lib/go-tc"
)

func TestDeliveryServices(t *testing.T) {

	CreateTestDeliveryServices(t)
	UpdateTestDeliveryServices(t)
	GetTestDeliveryServices(t)
	DeleteTestDeliveryServices(t)

}

func CreateTestDeliveryServices(t *testing.T) {

	for _, ds := range testData.DeliveryServices {
		resp, _, err := TOSession.CreateDeliveryService(ds)
		log.Debugln("Response: ", resp)
		if err != nil {
			t.Errorf("could not CREATE deliveryservices: %v\n", err)
		}
	}

}

func UpdateTestDeliveryServices(t *testing.T) {

	firstDeliveryService := testData.DeliveryServices[0]
	// Retrieve the DeliveryService by name so we can get the id for the Update
	resp, _, err := TOSession.GetDeliveryServiceByName(firstDeliveryService.Name)
	if err != nil {
		t.Errorf("cannot GET DeliveryService by name: %v - %v\n", firstDeliveryService.Name, err)
	}
	remoteDeliveryService := resp[0]
	expectedDeliveryServiceName := "TestDeliveryServices1"
	remoteDeliveryService.Name = expectedDeliveryServiceName
	var alert tc.Alerts
	alert, _, err = TOSession.UpdateDeliveryServiceByID(remoteDeliveryService.ID, remoteDeliveryService)
	if err != nil {
		t.Errorf("cannot UPDATE DeliveryService by id: %v - %v\n", err, alert)
	}

	// Retrieve the DeliveryService to check DeliveryService name got updated
	resp, _, err = TOSession.GetDeliveryServiceByID(remoteDeliveryService.ID)
	if err != nil {
		t.Errorf("cannot GET DeliveryService by name: %v - %v\n", firstDeliveryService.Name, err)
	}
	respDeliveryService := resp[0]
	if respDeliveryService.Name != expectedDeliveryServiceName {
		t.Errorf("results do not match actual: %s, expected: %s\n", respDeliveryService.Name, expectedDeliveryServiceName)
	}

}

func GetTestDeliveryServices(t *testing.T) {

	for _, ds := range testData.DeliveryServices {
		resp, _, err := TOSession.GetDeliveryServiceByName(ds.Name)
		if err != nil {
			t.Errorf("cannot GET DeliveryService by name: %v - %v\n", err, resp)
		}
	}
}

func DeleteTestDeliveryServices(t *testing.T) {

	secondDeliveryService := testData.DeliveryServices[1]
	resp, _, err := TOSession.DeleteDeliveryServiceByName(secondDeliveryService.Name)
	if err != nil {
		t.Errorf("cannot DELETE DeliveryService by name: %v - %v\n", err, resp)
	}

	// Retrieve the DeliveryService to see if it got deleted
	ds, _, err := TOSession.GetDeliveryServiceByName(secondDeliveryService.Name)
	if err != nil {
		t.Errorf("error deleting DeliveryService name: %s\n", err.Error())
	}
	if len(ds) > 0 {
		t.Errorf("expected DeliveryService name: %s to be deleted\n", secondDeliveryService.Name)
	}
}
