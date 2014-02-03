grunt-new [![Build Status](https://travis-ci.org/hurrymaplelad/grunt-new.png)](https://travis-ci.org/hurrymaplelad/grunt-new)
=========

Minimal generator. Add files to existing projects. Mix and match template engines.  Anything supporting the [Consolidate.js](https://github.com/visionmedia/consolidate.js/) signature will do.

```shell
npm install --save-dev grunt-new
```

Given a template file like `templates/post.hbs`:
```yaml
---
title: {{title}}
author: {{author}}
---
```

You can do something real basic like

```js
grunt.loadNpmTasks('grunt-new');

grunt.initConfig({
  'new': {
    options: {
      engine: consolidate.handlebars
    }
    post: {
      template: 'templates/post.hbs',
      data: {
        title: 'Placeholder title',
        author: 'Your name here',
        dest: 'src/posts/my-new-post.md'
      }
    },
  },
})
```

Or something fancy like

```coffee
pkg = require './package.json'
require('normalize-package-data')(pkg)
inquirer = require 'inquirer'

grunt.loadNpmTasks 'grunt-new'

grunt.initConfig
  new:
    options:
      engine: consolidate.handlebars
    post:
      template: 'templates/post.hbs',
      data: (done) ->
        # prompt the user for the title of the new post
        inquirer.prompt [name: 'title', message: 'Title?'], ({title}) ->
          # timestamp the new post filename
          date = grunt.template.today 'yyyy-mm-dd'
          slug = grunt.util._.dasherize title.toLowerCase()
          done null,
            title: title
            author: pkg.author.name # grab the author name from package.json
            dest: "src/#{date}/#{slug}.md"
```


## Options

#### engine
Type: `Function`
Default value: [`_.template`](http://lodash.com/docs#template)

A function that implements the [Consolidate.js signature](https://github.com/visionmedia/consolidate.js/#api): `function(path, data, callback)` and
calls its callback with `(err, string)`.
