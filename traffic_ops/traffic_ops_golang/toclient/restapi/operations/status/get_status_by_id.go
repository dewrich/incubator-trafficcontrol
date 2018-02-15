// Code generated by go-swagger; DO NOT EDIT.

package status

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the generate command

import (
	"net/http"

	middleware "github.com/go-openapi/runtime/middleware"
)

// GetStatusByIDHandlerFunc turns a function with the right signature into a get status by Id handler
type GetStatusByIDHandlerFunc func(GetStatusByIDParams, interface{}) middleware.Responder

// Handle executing the request and returning a response
func (fn GetStatusByIDHandlerFunc) Handle(params GetStatusByIDParams, principal interface{}) middleware.Responder {
	return fn(params, principal)
}

// GetStatusByIDHandler interface for that can handle valid get status by Id params
type GetStatusByIDHandler interface {
	Handle(GetStatusByIDParams, interface{}) middleware.Responder
}

// NewGetStatusByID creates a new http.Handler for the get status by Id operation
func NewGetStatusByID(ctx *middleware.Context, handler GetStatusByIDHandler) *GetStatusByID {
	return &GetStatusByID{Context: ctx, Handler: handler}
}

/*GetStatusByID swagger:route GET /statuses/{id} Status getStatusById

Retrieve a specific Status

*/
type GetStatusByID struct {
	Context *middleware.Context
	Handler GetStatusByIDHandler
}

func (o *GetStatusByID) ServeHTTP(rw http.ResponseWriter, r *http.Request) {
	route, rCtx, _ := o.Context.RouteInfo(r)
	if rCtx != nil {
		r = rCtx
	}
	var Params = NewGetStatusByIDParams()

	uprinc, aCtx, err := o.Context.Authorize(r, route)
	if err != nil {
		o.Context.Respond(rw, r, route.Produces, route, err)
		return
	}
	if aCtx != nil {
		r = aCtx
	}
	var principal interface{}
	if uprinc != nil {
		principal = uprinc
	}

	if err := o.Context.BindValidRequest(r, route, &Params); err != nil { // bind params
		o.Context.Respond(rw, r, route.Produces, route, err)
		return
	}

	res := o.Handler.Handle(Params, principal) // actually handle the request

	o.Context.Respond(rw, r, route.Produces, route, res)

}
