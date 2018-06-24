'use strict'

fs = require 'fs'
pug = require 'pug'

export write-html = (view, options, file) ->
  options.compileDebug = false;
  fs.writeFileSync(file + ".html", (pug.renderFile view, options))

export write-json = (db, path) ->
  file = path + '.json'
  data = JSON.stringify db, null, 2
  fs.write-file-sync file, data
