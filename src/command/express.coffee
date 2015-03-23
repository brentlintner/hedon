util = require "./util"
logger = require "./../logger"
install = require "./express/install"
create = require "./express/create"
run = require "./express/run"
log = logger.create "express"

keyword = [
  "express application",
  "express app",
  "express server"
]

create_app = [
  "create an",
  "create a"
]

run_app = [
  "run my express application",
  "run my express",
  "run express",
  "start express application"
]

host_static = "should host"

handle = (sentence) ->
  if util.sentence_has keyword, sentence
    if util.sentence_has create_app, sentence
      create.create()

    if util.sentence_has host_static, sentence
      dir = util.value_for host_static, sentence

      if dir then create.static_host dir
      else log.warn "no directory to host. got '#{dir}'"

    if util.sentence_has run_app, sentence
      run.run()

module.exports =
  handle: handle
