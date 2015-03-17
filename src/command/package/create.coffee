util = require "./../util"
fs = require "fs"
logger = require "./../../logger"
log = logger.create "package/create"

basic_pkg =
  name: "my-pkg-name",
  version: "0.0.0",
  description: "My first pkg",
  scripts: {}
  dependencies: {}
  devDependencies: {}

basic_package_json = ->
  JSON.stringify basic_pkg, null, 2

create_package_json = () ->
  log.info "creating a basic package file"
  fs.writeFileSync "package.json", basic_package_json()

module.exports =
  create: create_package_json
