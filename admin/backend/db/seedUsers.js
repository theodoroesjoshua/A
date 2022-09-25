#! /usr/bin/env node

require('dotenv').config()
console.log('This script populates few users to the database');

const async = require('async')
const db = require('./index.js')
const role = require("../_helpers/role");
const branch = require("../_helpers/branch");
const bcrypt = require("bcryptjs");

function userCreate(username, password, branch, role, cb) {
  let user = {
    username: username,
    branch: branch,
    role: role,
    hash_password: "",
  }

  bcrypt.genSalt(10, (err, salt) => {
    bcrypt.hash(password, salt, (err, hash) => {
      if (err) {
        console.log("Something went wrong in encrypting password")
        return
      }

      user.hash_password = hash;

      const query = {
        text: 'INSERT INTO admins (username, hash_password, branch, role) VALUES($1, $2, $3, $4)',
        values: [user.username, user.hash_password, user.branch, user.role],
      }

      db.query(query, (err, res) => {
        if (err) {
          cb(err, null)
          return
        }

        console.log("New User: " + user)
        cb(null, user)
      })
    });
  });
}

function createUsers(cb) {
  async.series([
    function(callback) {
      userCreate('DeSuperAdmin', '12345678', branch.makassar, role.superadmin, callback);
    },
    function(callback) {
      userCreate('MksAdmin', '12345678', branch.makassar, role.admin, callback);
    },
  ], cb);
}

createUsers((err, results) => {
  if (err) {
    console.log("FINAL ERR: " + err);
  }
  else {
    console.log("Database seeding is successful, press ctrl+C to exit...");
  }
});
