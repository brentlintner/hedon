util = require "./../util"
logger = require "./../../logger"
log = logger.create "express/install"

# TODO: use package.install

install = ->
  log.info "installing express"
  util.exec "npm install --save express"

module.exports =
  install: install
