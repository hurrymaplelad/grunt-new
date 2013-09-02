pkg = require '../package.json'
path = require 'path'

module.exports = (grunt) ->

  defaults =
    engine: (path, data, cb) ->
      template = grunt.file.read path
      rendered = grunt.template.process template, {data}
      cb null, rendered

  grunt.registerMultiTask 'new', pkg.description, ->
    done = @async()
    _ = grunt.util._
    {data, engine, template} = _.defaults(
      @data
      @options()
      defaults
    )

    # normalize data to a function that takes a callback
    if typeof data isnt 'function' then do ->
      value = data
      data = (cb) -> cb null, value
    unless data.length then do ->
      valueFn = data
      data = (cb) -> cb null, valueFn()

    data (err, data) ->
      return done(err) if err
      engine template, data, (err, rendered) ->
        grunt.file.write data.dest, rendered
        grunt.log.oklns "Wrote #{data.dest}"
        done(err)
