app = require "commander"
parser = require "./parser"
command = require "./command"
pkg = require "./../package.json"
examples = """

  Examples:

    hedon -f file.txt

    hedon -s "I need an express application."

"""

configure = ->
  app
    .version pkg.version
    .usage "[options]"
    .option "-f, --file [path]",
            "File to read commands from."
    .option "-s, --string [string]",
            "String command to run"

  app.outputHelp() if not process.argv.slice(2).length

  app.on "--help", ->
    console.log examples

interpret = (argv) ->
  configure()
  app.parse argv

  if app.file
    command.run(parser.parse_file app.file)

  if app.string
    command.run(parser.parse_string app.string)

module.exports =
  interpret: interpret
