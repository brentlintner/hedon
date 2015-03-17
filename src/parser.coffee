fs = require "fs"
logger = require "./logger"
ParseLatin = require "parse-latin"
latin = new ParseLatin()
log = logger.create "parser"

parse = (data) -> latin.parse data

parse_file_into_nlcst = (file) ->
  parse fs.readFileSync file, "utf-8"

parse_string_into_nlcst = (string) ->
  parse string

module.exports =
  parse_file: parse_file_into_nlcst
  parse_string: parse_string_into_nlcst
