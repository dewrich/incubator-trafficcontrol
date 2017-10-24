type _ struct {
	Asns []struct {
		CachegroupName string `json:"cachegroupName"`
		Name           string `json:"name"`
	} `json:"asns"`
	Cachegroups []struct {
		Latitude             interface{} `json:"latitude"`
		Longitude            interface{} `json:"longitude"`
		Name                 string      `json:"name"`
		ParentCacheGroupName interface{} `json:"parentCacheGroupName"`
		ShortName            string      `json:"shortName"`
	} `json:"cachegroups"`
	Cdns []struct {
		DnssecEnabled string `json:"dnssecEnabled"`
		DomainName    string `json:"domainName"`
		Name          string `json:"name"`
	} `json:"cdns"`
	DeliveryServices []struct {
		Active     bool   `json:"active"`
		Dscp       int64  `json:"dscp"`
		TenantName string `json:"tenantName"`
		XmlId      string `json:"xmlId"`
	} `json:"deliveryServices"`
	Divisions []struct {
		Name string `json:"name"`
	} `json:"divisions"`
	Regions []struct {
		DivisionName string `json:"divisionName"`
		Name         string `json:"name"`
	} `json:"regions"`
	Tenants []struct {
		Active           bool        `json:"active"`
		Name             string      `json:"name"`
		ParentTenantName interface{} `json:"parentTenantName"`
	} `json:"tenants"`
}

