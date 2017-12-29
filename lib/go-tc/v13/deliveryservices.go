package v13

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

// This struct supports /api/1.3

// DeliveryService ...
type DeliveryService struct {
	// NOTE: Fields that are pointers (with an asterisk (*) are required
	// for existence checking
	Active               *bool                  `json:"active"`
	CCRDNSTTL            int                    `json:"ccrDnsTtl"`
	CDNID                *int                   `json:"cdnId"`
	CDNName              string                 `json:"cdnName"`
	CacheURL             string                 `json:"cacheurl"`
	CheckPath            string                 `json:"checkPath"`
	DNSBypassCname       string                 `json:"dnsBypassCname"`
	DNSBypassIP          string                 `json:"dnsBypassIp"`
	DNSBypassIP6         string                 `json:"dnsBypassIp6"`
	DNSBypassTTL         int                    `json:"dnsBypassTtl"`
	DSCP                 *int                   `json:"dscp"`
	DisplayName          *string                `json:"displayName"`
	EdgeHeaderRewrite    string                 `json:"edgeHeaderRewrite"`
	ExampleURLs          []string               `json:"exampleURLs"`
	GeoLimit             *int                   `json:"geoLimit"`
	GeoProvider          *int                   `json:"geoProvider"`
	GlobalMaxMBPS        *int                   `json:"globalMaxMbps"`
	GlobalMaxTPS         *int                   `json:"globalMaxTps"`
	HTTPBypassFQDN       string                 `json:"httpBypassFqdn"`
	ID                   int                    `json:"id"`
	IPV6RoutingEnabled   bool                   `json:"ipv6RoutingEnabled"`
	InfoURL              string                 `json:"infoUrl"`
	InitialDispersion    int                    `json:"initialDispersion"`
	LastUpdated          string                 `json:"lastUpdated"`
	LogsEnabled          *bool                  `json:"logsEnabled"`
	LongDesc             string                 `json:"longDesc"`
	LongDesc1            string                 `json:"longDesc1"`
	LongDesc2            string                 `json:"longDesc2"`
	MatchList            []DeliveryServiceMatch `json:"matchList,omitempty"`
	MaxDNSAnswers        int                    `json:"maxDnsAnswers"`
	MidHeaderRewrite     string                 `json:"midHeaderRewrite"`
	MissLat              float64                `json:"missLat"`
	MissLong             float64                `json:"missLong"`
	MultiSiteOrigin      bool                   `json:"multiSiteOrigin"`
	OrgServerFQDN        string                 `json:"orgServerFqdn"`
	ProfileDesc          string                 `json:"profileDescription"`
	ProfileID            int                    `json:"profileId,omitempty"`
	ProfileName          string                 `json:"profileName"`
	Protocol             int                    `json:"protocol"`
	QStringIgnore        int                    `json:"qstringIgnore"`
	RangeRequestHandling int                    `json:"rangeRequestHandling"`
	RegexRemap           string                 `json:"regexRemap"`
	RegionalGeoBlocking  *bool                  `json:"regionalGeoBlocking"`
	RemapText            string                 `json:"remapText"`
	RoutingName          string                 `json:"routingName"`
	Signed               bool                   `json:"signed"`
	TRResponseHeaders    string                 `json:"trResponseHeaders"`
	TenantID             int                    `json:"tenant_id,omitempty"`
	Type                 string                 `json:"type"`
	TypeID               *int                   `json:"typeId"`
	XMLID                *string                `json:"xmlId"`
}

// DeliveryServiceMatch ...
type DeliveryServiceMatch struct {
	Type      string `json:"type"`
	SetNumber int    `json:"setNumber"`
	Pattern   string `json:"pattern"`
}
