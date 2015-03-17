util = require "./../util"
logger = require "./../../logger"
log = logger.create "express/run"

run = ->
  log.info "running application"
  util.exec "node lib/app.js"

module.exports =
  run: run
