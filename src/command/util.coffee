_ = require "lodash"
shell = require "shelljs"
logger = require "./../logger"
nlcst = require "./util/nlcst"
log = logger.create "util"

_sentence_has = (string, sentence) ->
  words = []

  sentence.children.forEach (node) ->
    if node.type == nlcst.word
      i = node.children.reduce(
        (p, c) -> p + c.value.toLowerCase(),
        "")
      words.push i

  !!words.join(" ").match(new RegExp string)

sentence_has = (iterator, sentence) ->
  has = false

  if typeof iterator != "string"
    _.each iterator, (item) ->
      if !has then has = _sentence_has item, sentence
      if has then false
  else
    has = _sentence_has iterator, sentence

  has

value_for = (prefix, sentence) ->
  words = []
  match = prefix.split(" ")
  len = match.length

  values = []

  found = false

  sentence.children.forEach (node) ->
    found = false if variable_closed node
    values.push(node_value node) if found
    found = true if variable_opened node

  values.join ""

node_value = (node) ->
  if node.type == nlcst.word
    node.children.reduce(
      (p, c) -> p + c.value.toLowerCase(),
      "")
  else
    node.value

variable_opened = (node) ->
  node.type == nlcst.punctuation &&
  node.value == "{"

variable_closed = (node) ->
  node.type == nlcst.punctuation &&
  node.value == "}"

exec = (cmd) ->
  result = shell.exec cmd

  if result.code != 0
    log.error "cmd code was #{result.code}"
    process.exit result.code

module.exports =
  sentence_has: sentence_has
  value_for: value_for
  exec: exec
