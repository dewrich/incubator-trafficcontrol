/*
   Copyright 2015 Comcast Cable Communications Management, LLC

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

package client_tests

import (
	"flag"
	"fmt"
	"testing"

	log "github.com/apache/incubator-trafficcontrol/lib/go-log"
)

// Succeed is the Unicode codepoint for a check mark.
const Succeed = "\u2713"

// Failed is the Unicode codepoint for an X mark.
const Failed = "\u2717"

func init() {

	var cfg Config
	var err error
	var errorToLog error
	configFileName := flag.String("cfg", "", "The config file path")
	dbConfigFileName := flag.String("dbcfg", "", "The db config file path")
	if cfg, err = LoadConfig(*configFileName, *dbConfigFileName); err != nil {
		errorToLog = err
	}

	if err := log.InitCfg(cfg); err != nil {
		fmt.Printf("Error initializing loggers: %v\n", err)
		return
	}
	log.Warnln(errorToLog)
}

// Context is a summary of the test being run.
func Context(t *testing.T, msg string, args ...interface{}) {
	t.Log(fmt.Sprintf(msg, args...))
}

// Fatal contains details of a failed test and stops its execution.
func Fatal(t *testing.T, msg string, args ...interface{}) {
	m := fmt.Sprintf(msg, args...)
	t.Fatal(fmt.Sprintf("\t %-80s", m), Failed)
}

// Error contails details of a failed test and continues execution.
func Error(t *testing.T, msg string, args ...interface{}) {
	m := fmt.Sprintf(msg, args...)
	t.Error(fmt.Sprintf("\t %-80s", m), Failed)
}

// Success contains details of a successful test.
func Success(t *testing.T, msg string, args ...interface{}) {
	m := fmt.Sprintf(msg, args...)
	t.Log(fmt.Sprintf("\t %-80s", m), Succeed)
}

// ErrorLog - critical messages
func (c Config) ErrorLog() log.LogLocation {
	return log.LogLocation(c.LogLocationError)
}

// WarningLog - warning messages
func (c Config) WarningLog() log.LogLocation {
	return log.LogLocation(c.LogLocationWarning)
}

// InfoLog - information messages
func (c Config) InfoLog() log.LogLocation { return log.LogLocation(c.LogLocationInfo) }

// DebugLog - troubleshooting messages
func (c Config) DebugLog() log.LogLocation {
	return log.LogLocation(c.LogLocationDebug)
}

// EventLog - access.log high level transactions
func (c Config) EventLog() log.LogLocation {
	return log.LogLocation(c.LogLocationEvent)
}
