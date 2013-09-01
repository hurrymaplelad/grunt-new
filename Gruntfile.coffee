{filterDev} = require 'matchdep'
cons = require 'consolidate'
pkg = require './package.json'
require('normalize-package-data')(pkg)

module.exports = (grunt) ->
  grunt.initConfig

    clean:
      tests: ['temp']

    new:
      'post-simple':
        template: 'test/fixtures/post.ld'
        data:
          title: 'The Four Humors'
          author: 'Hippocrates'
          dest: 'temp/post-simple.md'

      'post-fancy':
        engine: cons.handlebars
        template: 'test/fixtures/post.hbs'
        data: (done) ->
          setTimeout ->
            title = 'The Four Humors'
            date = 'Jan 1 2001'
            dasherize = grunt.util._.dasherize
            formatDate = grunt.template.date
            done null,
              title: title
              author: pkg.author.name
              dest: "temp/#{formatDate(date, 'yyyy-mm-dd')}/#{dasherize title.toLowerCase()}.md"
          , 1

    simplemocha:
      test:
        src: 'test/*.test.coffee'
        options:
          compilers: 'coffee:coffee-script'


  filterDev('grunt-*').forEach grunt.loadNpmTasks
  grunt.loadTasks 'tasks'

  grunt.registerTask 'test', [
    'clean'
    'new:post-simple'
    'new:post-fancy'
    'simplemocha'
  ]

  grunt.registerTask 'default', ['test']
