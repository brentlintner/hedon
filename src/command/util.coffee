_ = require "lodash"
shell = require "shelljs"
logger = require "./../logger"
log = logger.create "util"

# TODO: string could be an array of strings
sentence_has = (string, sentence) ->
  words = []

  sentence.children.forEach (node) ->
    if node.type == "WordNode"
      i = node.children.reduce(
        (p, c) -> p + c.value.toLowerCase(),
        "")
      words.push i

  has = words.join(" ").match(new RegExp string)

  has

value_for = (prefix, sentence) ->
  words = []
  match = prefix.split(" ")
  len = match.length

  values = []

  found = false

  sentence.children.forEach (node) ->
    if node.type == "PunctuationNode" &&
       node.value == "}"
      found = false

    if found
      if node.type == "WordNode"
        i = node.children.reduce(
          (p, c) -> p + c.value.toLowerCase(),
          "")

        values.push i

      else
        values.push node.value

    if node.type == "PunctuationNode" &&
       node.value == "{"
      found = true

  value = values.join ""

  value

exec = (cmd) ->
  result = shell.exec cmd

  if result.code != 0
    log.error "cmd code was #{result.code}"
    process.exit result.code

module.exports =
  sentence_has: sentence_has
  value_for: value_for
  exec: exec
