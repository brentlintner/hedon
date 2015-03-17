util = require "./../util"
fs = require "fs"

basic_pkg =
  name: "my-bower-pkg"
  dependencies: {}
  devDependencies: {}

basic_package_json = ->
  JSON.stringify basic_pkg, null, 2

create_bower_json = () ->
  fs.writeFileSync "package.json", basic_package_json

module.exports =
  create: create_bower_json
  install: install_package
