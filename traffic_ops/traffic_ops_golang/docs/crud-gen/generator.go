package main

import (
	"io/ioutil"
	"log"
	"os"
	"text/template"
)

type Parameters struct {
	OutputFile       string
	Entity           string
	EntityPlural     string
	Route            string
	QueryParamFields []Fields
	PutParamFields   []Fields
}
type Fields struct {
	FieldName string
	FieldDoc  string
	FieldType string
	APIField  string
}

func writeASNs() {

	p := Parameters{
		OutputFile:   "asns.go",
		Entity:       "ASN",
		EntityPlural: "ASNs",
		Route:        "/asns",
		QueryParamFields: []Fields{
			Fields{
				FieldName: "asn",
				FieldDoc:  "Autonomous System Numbers per APNIC for identifying a service provider",
				FieldType: "string",
				APIField:  "asn",
			},
			Fields{
				FieldName: "Cachegroup",
				FieldDoc:  "Related cachegroup name",
				FieldType: "string",
				APIField:  "cachegroup",
			},
			Fields{
				FieldName: "CachegroupID",
				FieldDoc:  "Related cachegroup id",
				FieldType: "string",
				APIField:  "cachegroupId",
			},
			Fields{
				FieldName: "ID",
				FieldDoc:  "Unique identifier for the CDN",
				FieldType: "string",
				APIField:  "id",
			},
			Fields{
				FieldName: "Orderby",
				FieldType: "string",
				APIField:  "orderby",
			},
		},
		PutParamFields: []Fields{
			Fields{
				FieldName: "ID",
				FieldType: "int",
				APIField:  "id",
			},
		},
	}
	writeFile(p)

}

func writeCDNs() {

	p := Parameters{
		OutputFile:   "cdns.go",
		Entity:       "CDN",
		EntityPlural: "CDNs",
		Route:        "/cdns",
		QueryParamFields: []Fields{
			Fields{
				FieldName: "DNSSecEnabled",
				FieldDoc:  "Enables Domain Name System Security Extensions (DNSSEC) for the CDN",
				FieldType: "string",
				APIField:  "dnssecEnabled",
			},
			Fields{
				FieldName: "DomainName",
				FieldDoc:  "The domain name for the CDN",
				FieldType: "string",
				APIField:  "domainName",
			},
			Fields{
				FieldName: "ID",
				FieldDoc:  "Unique identifier for the CDN",
				FieldType: "string",
				APIField:  "id",
			},
			Fields{
				FieldName: "Name",
				FieldDoc:  "The CDN name for the CDN",
				FieldType: "string",
				APIField:  "name",
			},
			Fields{
				FieldName: "Orderby",
				FieldType: "string",
				APIField:  "orderby",
			},
		},
		PutParamFields: []Fields{
			Fields{
				FieldName: "ID",
				FieldType: "int",
				APIField:  "id",
			},
		},
	}
	writeFile(p)

}

func writeDivisions() {
	p := Parameters{
		OutputFile:   "divisions.go",
		Entity:       "Division",
		EntityPlural: "Divisions",
		Route:        "/divisions",
		QueryParamFields: []Fields{
			Fields{
				FieldName: "Name",
				FieldDoc:  "Name for this Division",
				FieldType: "string",
				APIField:  "name",
			},
			Fields{
				FieldName: "ID",
				FieldDoc:  "Unique identifier for the Division",
				FieldType: "string",
				APIField:  "id",
			},
			Fields{
				FieldName: "Orderby",
				FieldType: "string",
				APIField:  "orderby",
			},
		},
		PutParamFields: []Fields{
			Fields{
				FieldName: "ID",
				FieldType: "int",
				APIField:  "id",
			},
		},
	}
	writeFile(p)

}

func writeRegions() {
	p := Parameters{
		OutputFile:   "regions.go",
		Entity:       "Region",
		EntityPlural: "Regions",
		Route:        "/regions",
		QueryParamFields: []Fields{
			Fields{
				FieldName: "Division",
				FieldDoc:  "Division ID that refers to this Region",
				FieldType: "string",
				APIField:  "division",
			},
			Fields{
				FieldName: "DivisionName",
				FieldDoc:  "Division Name that refers to this Region",
				FieldType: "string",
				APIField:  "divisionName",
			},
			Fields{
				FieldName: "ID",
				FieldDoc:  "Unique identifier for the Region",
				FieldType: "string",
				APIField:  "id",
			},
			Fields{
				FieldName: "Orderby",
				FieldType: "string",
				APIField:  "orderby",
			},
		},
		PutParamFields: []Fields{
			Fields{
				FieldName: "ID",
				FieldType: "int",
				APIField:  "id",
			},
		},
	}
	writeFile(p)

}

func writeStatuses() {
	p := Parameters{
		OutputFile:   "statuses.go",
		Entity:       "Status",
		EntityPlural: "Statuses",
		Route:        "/statuses",
		QueryParamFields: []Fields{
			Fields{
				FieldName: "Name",
				FieldDoc:  "The name that refers to this Status",
				FieldType: "string",
				APIField:  "name",
			},
			Fields{
				FieldName: "Description",
				FieldDoc:  "A short description of the status",
				FieldType: "string",
				APIField:  "description",
			},
			Fields{
				FieldName: "ID",
				FieldDoc:  "Unique identifier for the Status",
				FieldType: "string",
				APIField:  "id",
			},
			Fields{
				FieldName: "Orderby",
				FieldType: "string",
				APIField:  "orderby",
			},
		},
		PutParamFields: []Fields{
			Fields{
				FieldName: "ID",
				FieldType: "int",
				APIField:  "id",
			},
		},
	}
	writeFile(p)

}

func writeFile(p Parameters) {
	tmpl := template.New("test")

	dat, err := ioutil.ReadFile("tcdoc.gotmpl")
	if err != nil {
		log.Fatal("Parse: ", err)
		return
	}

	//parse some content and generate a template
	tmpl, err = tmpl.Parse(string(dat))
	if err != nil {
		log.Fatal("Parse: ", err)
		return
	}

	outputDir := "./output"
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		os.Mkdir(outputDir, os.ModePerm)
	}
	f, err := os.Create(outputDir + "/" + p.OutputFile)
	if err != nil {
		log.Println("create file: ", err)
		return
	}

	//merge template 'tmpl' with content of 's'
	err = tmpl.Execute(f, p)
	if err != nil {
		log.Fatal("Execute: ", err)
		return
	}

	f.Close()
}

func main() {
	writeASNs()
	writeCDNs()
	writeDivisions()
	writeRegions()
	writeStatuses()
}
