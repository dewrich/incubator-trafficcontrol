package srvhttp

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import (
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
	"net/url"
	"sync"
	"time"

	"github.com/apache/incubator-trafficcontrol/lib/go-log"
	"github.com/hydrogen18/stoppableListener"
)

// GetCommonAPIData calculates and returns API data common to most endpoints
func GetCommonAPIData(params url.Values, t time.Time) CommonAPIData {
	return CommonAPIData{
		QueryParams: ParametersStr(params),
		DateStr:     DateStr(t),
	}
}

// CommonAPIData contains generic data common to most endpoints.
type CommonAPIData struct {
	QueryParams string `json:"pp"`
	DateStr     string `json:"date"`
}

// Server is a re-runnable HTTP server. Server.Run() may be called repeatedly, and
// each time the previous running server will be stopped, and the server will be
// restarted with the new port address and data request channel.
type Server struct {
	stoppableListener          *stoppableListener.StoppableListener
	stoppableListenerWaitGroup sync.WaitGroup
}

func (s *Server) registerEndpoints(sm *http.ServeMux, endpoints map[string]http.HandlerFunc, staticFileDir string) error {
	handleRoot, err := s.handleRootFunc(staticFileDir)
	if err != nil {
		return fmt.Errorf("Error getting root endpoint: %v", err)
	}
	handleSortableJs, err := s.handleSortableFunc(staticFileDir)
	if err != nil {
		return fmt.Errorf("Error getting sortable endpoint: %v", err)
	}

	for path, f := range endpoints {
		sm.HandleFunc(path, f)
	}

	sm.HandleFunc("/", handleRoot)
	sm.HandleFunc("/sorttable.js", handleSortableJs)

	return nil
}

// Run runs a new HTTP service at the given addr, making data requests to the given c.
// Run may be called repeatedly, and each time, will shut down any existing service first.
// Run is NOT threadsafe, and MUST NOT be called concurrently by multiple goroutines.
func (s *Server) Run(endpoints map[string]http.HandlerFunc, addr string, readTimeout time.Duration, writeTimeout time.Duration, staticFileDir string) error {
	if s.stoppableListener != nil {
		log.Infof("Stopping Web Server\n")
		s.stoppableListener.Stop()
		s.stoppableListenerWaitGroup.Wait()
	}
	log.Infof("Starting Web Server\n")

	var err error
	var originalListener net.Listener
	if originalListener, err = net.Listen("tcp", addr); err != nil {
		return err
	}
	if s.stoppableListener, err = stoppableListener.New(originalListener); err != nil {
		return err
	}

	sm := http.NewServeMux()
	err = s.registerEndpoints(sm, endpoints, staticFileDir)
	if err != nil {
		return err
	}
	server := &http.Server{
		Addr:           addr,
		Handler:        sm,
		ReadTimeout:    readTimeout,
		WriteTimeout:   writeTimeout,
		MaxHeaderBytes: 1 << 20,
	}

	s.stoppableListenerWaitGroup = sync.WaitGroup{}
	s.stoppableListenerWaitGroup.Add(1)
	go func() {
		defer s.stoppableListenerWaitGroup.Done()
		err := server.Serve(s.stoppableListener)
		if err != nil {
			if err != stoppableListener.StoppedError {
				log.Warnf("HTTP server stopped with error: %v\n", err)
			} else {
				log.Infof("Web server stopped on %s", addr)
			}
		}
	}()

	log.Infof("Web server listening on %s", addr)
	return nil
}

// ParametersStr takes the URL query parameters, and returns a string as used by the Traffic Monitor 1.0 endpoints "pp" key.
func ParametersStr(params url.Values) string {
	pp := ""
	for param, vals := range params {
		for _, val := range vals {
			pp += param + "=[" + val + "], "
		}
	}
	if len(pp) > 2 {
		pp = pp[:len(pp)-2]
	}
	return pp
}

//CommonAPIDataDataFormat is a common Date format for the API
const CommonAPIDataDateFormat = "Mon Jan 02 15:04:05 UTC 2006"

// DateStr returns the given time in the format expected by Traffic Monitor 1.0 API users
func DateStr(t time.Time) string {
	return t.UTC().Format(CommonAPIDataDateFormat)
}

func (s *Server) handleRootFunc(staticFileDir string) (http.HandlerFunc, error) {
	return s.handleFile(staticFileDir + "/index.html")
}

func (s *Server) handleSortableFunc(staticFileDir string) (http.HandlerFunc, error) {
	return s.handleFile(staticFileDir + "/sorttable.js")
}

func (s *Server) handleFile(name string) (http.HandlerFunc, error) {
	bytes, err := ioutil.ReadFile(name)
	if err != nil {
		return nil, err
	}
	contentType := http.DetectContentType(bytes)
	return func(w http.ResponseWriter, req *http.Request) {
		w.Header().Set("Content-Type", contentType)
		fmt.Fprintf(w, "%s", bytes)
	}, nil
}
