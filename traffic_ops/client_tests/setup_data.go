package client_tests

import (
	"database/sql"
	"fmt"

	log "github.com/apache/incubator-trafficcontrol/lib/go-log"
)

func prepareDatabase(cfg *Config) {
	fmt.Printf("cfg ---> %v\n", cfg)
}
func prepareDatabaseX(cfg Config) {

	var db *sql.DB
	log.Infoln("setupData")
	var err error

	sslStr := "require"
	if !cfg.DB.SSL {
		sslStr = "disable"
	}

	db, err = sql.Open("postgres", fmt.Sprintf("postgres://%s:%s@%s/%s?sslmode=%s", cfg.DB.User, cfg.DB.Password, cfg.DB.Hostname, cfg.DB.DBName, sslStr))
	if err != nil {
		log.Errorf("opening database: %v\n", err)
		return
	}

	defer db.Close()
	tx, err := db.Begin()
	if err != nil {
		log.Errorf("Transaction Failed", err)
	}
	//db.MustExec("insert into role (name, description, priv_level) VALUES ($1, $2, $3, $4)", "disallowed", "Block all access", "0")
	// Role
	res, err := tx.Exec("delete from role")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	res, err = tx.Exec("insert into role (id, name, description, priv_level) values (1, 'disallowed','Block all access',0) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	tx.Exec("insert into role (id, name, description, priv_level) values (2, 'read-only user','Block all access', 10) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}

	tx.Exec("insert into role (id, name, description, priv_level) values (3, 'operations','Block all access', 20) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	tx.Exec("insert into role (id, name, description, priv_level) values (4, 'admin','super-user', 30) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	tx.Exec("insert into role (id, name, description, priv_level) values (5, 'portal','Portal User', 2) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	tx.Exec("insert into role (id, name, description, priv_level) values (6, 'migrations','database migrations user - DO NOT REMOVE', 20) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}
	tx.Exec("insert into role (id, name, description, priv_level) values (7, 'federation','Role for Secondary CZF', 15) ON CONFLICT DO NOTHING")
	if err != nil {
		log.Errorf("Transaction Failed %v %v", err, res)
	}

	// Tmuser
	tx.Exec("CREATE EXTENSION IF NOT EXISTS pgcrypto")
	tx.Exec("delete from log")
	tx.Exec("delete from tm_user")
	tx.Exec("INSERT INTO tm_user (username, local_passwd, confirm_local_passwd, role) VALUES ('admin', ENCODE(DIGEST('password','sha1'),'hex'), ENCODE(DIGEST('password','sha1'),'hex'), 4)")

	tx.Commit()
	if err != nil {
		log.Infof(err.Error())
	}
}
