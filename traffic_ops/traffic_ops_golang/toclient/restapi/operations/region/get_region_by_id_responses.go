// Code generated by go-swagger; DO NOT EDIT.

package region

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/runtime"

	"github.com/apache/incubator-trafficcontrol.tor-api/traffic_ops/traffic_ops_golang/toclient/models"
)

// GetRegionByIDOKCode is the HTTP code returned for type GetRegionByIDOK
const GetRegionByIDOKCode int = 200

/*GetRegionByIDOK Regions -  RegionsResponse to get the "response" top level key

swagger:response getRegionByIdOK
*/
type GetRegionByIDOK struct {

	/*
	  In: Body
	*/
	Payload *models.RegionsResponse `json:"body,omitempty"`
}

// NewGetRegionByIDOK creates GetRegionByIDOK with default headers values
func NewGetRegionByIDOK() *GetRegionByIDOK {
	return &GetRegionByIDOK{}
}

// WithPayload adds the payload to the get region by Id o k response
func (o *GetRegionByIDOK) WithPayload(payload *models.RegionsResponse) *GetRegionByIDOK {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get region by Id o k response
func (o *GetRegionByIDOK) SetPayload(payload *models.RegionsResponse) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetRegionByIDOK) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(200)
	if o.Payload != nil {
		payload := o.Payload
		if err := producer.Produce(rw, payload); err != nil {
			panic(err) // let the recovery middleware deal with this
		}
	}
}

// GetRegionByIDBadRequestCode is the HTTP code returned for type GetRegionByIDBadRequest
const GetRegionByIDBadRequestCode int = 400

/*GetRegionByIDBadRequest Alerts - informs the client of server side messages

swagger:response getRegionByIdBadRequest
*/
type GetRegionByIDBadRequest struct {

	/*
	  In: Body
	*/
	Payload models.GetRegionByIDBadRequestBody `json:"body,omitempty"`
}

// NewGetRegionByIDBadRequest creates GetRegionByIDBadRequest with default headers values
func NewGetRegionByIDBadRequest() *GetRegionByIDBadRequest {
	return &GetRegionByIDBadRequest{}
}

// WithPayload adds the payload to the get region by Id bad request response
func (o *GetRegionByIDBadRequest) WithPayload(payload models.GetRegionByIDBadRequestBody) *GetRegionByIDBadRequest {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get region by Id bad request response
func (o *GetRegionByIDBadRequest) SetPayload(payload models.GetRegionByIDBadRequestBody) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetRegionByIDBadRequest) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(400)
	payload := o.Payload
	if payload == nil {
		payload = make(models.GetRegionByIDBadRequestBody, 0, 50)
	}

	if err := producer.Produce(rw, payload); err != nil {
		panic(err) // let the recovery middleware deal with this
	}

}
