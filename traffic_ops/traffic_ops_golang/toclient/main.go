package main

import (
	"crypto/tls"
	"fmt"
	"net"
	"time"

	"net/http"

	toclient "github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/toclient/client"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/toclient/client/cdn"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/toclient/client/region"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/toclient/models"
	"github.com/go-openapi/runtime"
	oclient "github.com/go-openapi/runtime/client"
)

func main() {
	getRegions()

	getCDNs()
	getCDNsByName()
	updateCDNs()
	getCDNs()
}

func getRegions() {
	// Setup the parameters for the REST call
	param := region.NewGetRegionsParams()

	// Disable Certificate check
	param.HTTPClient = &http.Client{
		Transport: InsecureTransport(),
	}

	cfg := toclient.TransportConfig{
		Host:     "localhost:8443",
		BasePath: "/api/1.3",
	}

	TO := toclient.NewHTTPClientWithConfig(nil, &cfg)

	// Sample GET call to the /api/1.3/regions endpoint
	resp, err := TO.Region.GetRegions(param, AuthInfoWriter())
	if err != nil {
		fmt.Printf("err ---> %v\n", err)
		return
	}

	for i := range resp.Payload.Response {
		fmt.Printf("getRegions() - /api/1.3/regions id: %v name: %v\n", resp.Payload.Response[i].ID, resp.Payload.Response[i].Name)
	}
}

func getCDNs() {
	// Setup the parameters for the REST call
	param := cdn.NewGetCDNsParams()

	// Disable Certificate check
	param.HTTPClient = &http.Client{
		Transport: InsecureTransport(),
	}

	cfg := toclient.TransportConfig{
		Host:     "localhost:8443",
		BasePath: "/api/1.3",
	}

	TO := toclient.NewHTTPClientWithConfig(nil, &cfg)

	// Sample GET call to the /api/1.3/cdns endpoint
	resp, err := TO.Cdn.GetCDNs(param, AuthInfoWriter())
	if err != nil {
		fmt.Printf("resp ---> %v\n", resp)
		fmt.Printf("err ---> %v\n", err)
		return
	}

	//for i := range resp.Payload.Response {
	//	fmt.Printf("getCDNS() - /api/1.3/cdns id: %v name: %v\n", resp.Payload.Response[i].ID, resp.Payload.Response[i].Name)
	//}
}

func updateCDNs() {
	cfg := toclient.TransportConfig{
		Host:     "localhost:8443",
		BasePath: "/api/1.3",
	}

	TO := toclient.NewHTTPClientWithConfig(nil, &cfg)

	// Setup the parameters for the REST call
	p := cdn.NewPutCDNParams()
	// Disable Certificate check
	p.HTTPClient = &http.Client{
		Transport: InsecureTransport(),
	}

	cdn := models.CDN{}

	updatedID := int64(100)
	p.SetID(updatedID)

	cdn.ID = &updatedID
	domainName := "new.domain"
	cdn.DomainName = &domainName

	updatedCDNName := "swagger-cdn"
	cdn.Name = &updatedCDNName

	const DNSSecEnabled = false
	dEnabled := DNSSecEnabled
	cdn.DNSSECEnabled = &dEnabled

	cdn.ID = &updatedID
	p.SetCDN(&cdn)

	// Sample PUT call to the /api/1.3/cdns endpoint
	resp, err := TO.Cdn.PutCDN(p, AuthInfoWriter())
	if err != nil {
		fmt.Printf("err.Error() ---> %v\n", err)
		fmt.Printf("resp ---> %v\n", resp)
		return
	}
	fmt.Printf("resp ---> %v\n", resp)
	if resp.Payload.Response != nil {
		fmt.Printf("resp ---> %v\n", *resp.Payload.Response.Name)
	}
}

func getCDNsByName() {
	// Setup the parameters for the REST call
	param := cdn.NewGetCDNsParams()
	name := "cdn1"
	param.WithName(&name)

	// Disable Certificate check
	param.HTTPClient = &http.Client{
		Transport: InsecureTransport(),
	}

	cfg := toclient.TransportConfig{
		Host:     "localhost:8443",
		BasePath: "/api/1.3",
	}

	TO := toclient.NewHTTPClientWithConfig(nil, &cfg)
	resp, err := TO.Cdn.GetCDNs(param, AuthInfoWriter())
	if err != nil {
		fmt.Printf("resp ---> %v\n", resp)
		fmt.Printf("err ---> %v\n", err)
		return
	}

	//for i := range resp.Payload.Response {
	//	fmt.Printf("getCDNsByName() - /api/1.3/cdns id: %v name: %v\n", resp.Payload.Response[i].ID, resp.Payload.Response[i].Name)
	//}
}

func AuthInfoWriter() runtime.ClientAuthInfoWriter {
	writer := oclient.APIKeyAuth("cookie", "header", "mojolicious=eyJhdXRoX2RhdGEiOiJhZG1pbiIsImV4cGlyZXMiOjE1MTg0NjYxMDJ9--0029382c15c8934acdbc1fb2002b8a74a411e774")
	return writer
}

func InsecureTransport() http.RoundTripper {
	return &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
		Dial: (&net.Dialer{
			Timeout: 5 * time.Second,
		}).Dial,
		TLSHandshakeTimeout: 5 * time.Second,
	}
}
