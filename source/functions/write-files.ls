'use strict'

fs = require 'fs'
require! jade

export write-html = (view, options, file) ->
  file = file + '.html'
  jade.render-file view, options, (err, html) ->
    fs.write-file-sync file, html

export write-json = (db, path) ->
  file = path + '.json'
  data = JSON.stringify db, null, 2
  fs.write-file-sync file, data
