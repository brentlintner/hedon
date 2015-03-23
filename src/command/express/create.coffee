fs = require "fs"
path = require "path"
logger = require "./../../logger"
util = require "./../util"
install = require "./install"
pkg = require "./../package/create"
log = logger.create "express/create"
basic_app = """
  var express = require("express");
  var app = express();

  app.get("/", function (req, res) {
    res.send("Hello World!");
  });

  var server = app.listen(3000, function () {
    console.log("listening at http://localhost:3000");
  });
"""

# TODO: should split up into 3 parts

static_host_app = (dir) -> "
    var express = require('express');
    var path = require('path');
    var static  = require('express-static');
    var app = express();

    app.use(static(path.join(__dirname, '..', '#{dir}')));

    var server = app.listen(3000, function () {
      console.log('listening at http://localhost:3000');
    });
  "

static_host = (dir) ->
  log.info "install express-static (for static hosting)"
  util.exec "npm install express-static --save"

  log.info "creating an app.js file to host #{dir}"
  fs.writeFileSync path.join("lib", "app.js"), static_host_app(dir)

# TODO: need to figure out how not to install twice, thrice, etc
create = ->
  log.info "creating an express application"

  if !fs.existsSync "package.json"
    pkg.create()

  install.install()

  log.info "making lib/ directory"

  if !fs.existsSync "lib"
    fs.mkdirSync "lib"

  log.info "creating an app.js file"
  fs.writeFileSync path.join("lib", "app.js"), basic_app

module.exports =
  create: create
  static_host: static_host
