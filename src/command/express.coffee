util = require "./util"
logger = require "./../logger"
install = require "./express/install"
create = require "./express/create"
run = require "./express/run"
log = logger.create "express"

handle = (sentence) ->
  if util.sentence_has "express application", sentence
    # TODO less brittle check
    if util.sentence_has "create an", sentence
      create.create()

    if util.sentence_has "should host", sentence
      console.log "I should host something.."
      dir = util.value_for "should host", sentence

      if dir then create.static_host dir

    if util.sentence_has "run my express application", sentence
      run.run()

module.exports =
  handle: handle
