grunt = require 'grunt'
expect = require 'expect.js'

describe 'grunt-new', ->

  it 'renders files from templates and data', ->
    expect(grunt.file.read('temp/post-simple.md')).to.eql """
      ---
      title: The Four Humors
      author: Hippocrates
      ---
    """

  it 'supports custom template engines and async data functions', ->
    expect(grunt.file.read('temp/2001-01-01/the-four-humors.md')).to.eql """
      ---
      title: The Four Humors
      author: Adam Hull
      ---
    """
