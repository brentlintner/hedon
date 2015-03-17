logger = require "./logger"
parser = require "./parser"
_ = require "lodash"
log = logger.create "cmd"
commands = require "./command/all"

sentences = (nlcst) ->
  sentences = []

  nlcst.children.forEach (node) ->
    if node.type == "ParagraphNode"
      node.children.forEach (subnode) ->
        sentences.push subnode

  sentences

command_names = (sentence) ->
  names = {}
  sentence.children.forEach (node) ->
    if node.type == "WordNode"
      if node.children
        node.children.forEach (part) ->
          _.each commands, (cmd, key) ->
            if key == part.value.toLowerCase()
              names[key] = [] if not names[key]
              names[key].push commands[key].handle.bind null, sentence

  names

run_command = (sentence) ->
  names = command_names sentence

  _.each names, (name, key) ->
    _.each name, (func) -> func()

run_commands_from_nlcst = (nlcst) ->
  log.debug "interpreting"

  sentences(nlcst).forEach (sentence) ->
    if sentence.children
      run_command sentence

module.exports =
  run: run_commands_from_nlcst
