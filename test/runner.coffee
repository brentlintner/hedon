path = require "path"
fs = require "fs"
wrench = require "wrench"
Mocha = require "mocha"
specs = path.join __dirname, "..", "test"

find = (spec_type) ->
  wrench
    .readdirSyncRecursive path.join(specs, spec_type)
    .filter (p) -> /\.js/.test p
    .map (p) -> path.resolve (path.join specs, spec_type, p)

all_specs = ->
  find("unit")
    .concat find("integration")

run = (type) ->
  runner = new Mocha
    ui: "bdd"
    reporter: "spec"
    timeout: 2000

  runner.files = all_specs()

  runner.run process.exit

module.exports =
  run: run
