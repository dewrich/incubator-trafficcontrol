// Code generated by go-swagger; DO NOT EDIT.

package asn

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the generate command

import (
	"errors"
	"net/url"
	golangswaggerpaths "path"
)

// GetASNsURL generates an URL for the get a s ns operation
type GetASNsURL struct {
	Cachegroup   *string
	CachegroupID *string
	ID           *string
	Orderby      *string

	_basePath string
	// avoid unkeyed usage
	_ struct{}
}

// WithBasePath sets the base path for this url builder, only required when it's different from the
// base path specified in the swagger spec.
// When the value of the base path is an empty string
func (o *GetASNsURL) WithBasePath(bp string) *GetASNsURL {
	o.SetBasePath(bp)
	return o
}

// SetBasePath sets the base path for this url builder, only required when it's different from the
// base path specified in the swagger spec.
// When the value of the base path is an empty string
func (o *GetASNsURL) SetBasePath(bp string) {
	o._basePath = bp
}

// Build a url path and query string
func (o *GetASNsURL) Build() (*url.URL, error) {
	var result url.URL

	var _path = "/asns"

	_basePath := o._basePath
	if _basePath == "" {
		_basePath = "/api/1.3"
	}
	result.Path = golangswaggerpaths.Join(_basePath, _path)

	qs := make(url.Values)

	var cachegroup string
	if o.Cachegroup != nil {
		cachegroup = *o.Cachegroup
	}
	if cachegroup != "" {
		qs.Set("cachegroup", cachegroup)
	}

	var cachegroupID string
	if o.CachegroupID != nil {
		cachegroupID = *o.CachegroupID
	}
	if cachegroupID != "" {
		qs.Set("cachegroupId", cachegroupID)
	}

	var id string
	if o.ID != nil {
		id = *o.ID
	}
	if id != "" {
		qs.Set("id", id)
	}

	var orderby string
	if o.Orderby != nil {
		orderby = *o.Orderby
	}
	if orderby != "" {
		qs.Set("orderby", orderby)
	}

	result.RawQuery = qs.Encode()

	return &result, nil
}

// Must is a helper function to panic when the url builder returns an error
func (o *GetASNsURL) Must(u *url.URL, err error) *url.URL {
	if err != nil {
		panic(err)
	}
	if u == nil {
		panic("url can't be nil")
	}
	return u
}

// String returns the string representation of the path with query string
func (o *GetASNsURL) String() string {
	return o.Must(o.Build()).String()
}

// BuildFull builds a full url with scheme, host, path and query string
func (o *GetASNsURL) BuildFull(scheme, host string) (*url.URL, error) {
	if scheme == "" {
		return nil, errors.New("scheme is required for a full url on GetASNsURL")
	}
	if host == "" {
		return nil, errors.New("host is required for a full url on GetASNsURL")
	}

	base, err := o.Build()
	if err != nil {
		return nil, err
	}

	base.Scheme = scheme
	base.Host = host
	return base, nil
}

// StringFull returns the string representation of a complete url
func (o *GetASNsURL) StringFull(scheme, host string) string {
	return o.Must(o.BuildFull(scheme, host)).String()
}
