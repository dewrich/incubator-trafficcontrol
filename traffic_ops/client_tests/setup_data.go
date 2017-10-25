package client_tests

import (
	"database/sql"
	"fmt"

	log "github.com/apache/incubator-trafficcontrol/lib/go-log"
)

func setupData(db *sql.DB) {

	log.Infof("Seeding Data...\n")

	tx, err := db.Begin()
	//db.MustExec("insert into role (name, description, priv_level) VALUES ($1, $2, $3, $4)", "disallowed", "Block all access", "0")
	// Role
	tx.Exec("delete from role")
	tx.Exec("insert into role (id, name, description, priv_level) values (1, 'disallowed','Block all access',0) ON CONFLICT DO NOTHING")
	tx.Exec("insert into role (id, name, description, priv_level) values (2, 'read-only user','Block all access', 10) ON CONFLICT DO NOTHING")

	tx.Exec("insert into role (id, name, description, priv_level) values (3, 'operations','Block all access', 20) ON CONFLICT DO NOTHING")
	tx.Exec("insert into role (id, name, description, priv_level) values (4, 'admin','super-user', 30) ON CONFLICT DO NOTHING")
	tx.Exec("insert into role (id, name, description, priv_level) values (5, 'portal','Portal User', 2) ON CONFLICT DO NOTHING")
	tx.Exec("insert into role (id, name, description, priv_level) values (6, 'migrations','database migrations user - DO NOT REMOVE', 20) ON CONFLICT DO NOTHING")
	tx.Exec("insert into role (id, name, description, priv_level) values (7, 'federation','Role for Secondary CZF', 15) ON CONFLICT DO NOTHING")
	fmt.Printf("tx ---> %v\n")

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
