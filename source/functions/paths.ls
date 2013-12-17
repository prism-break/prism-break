'use strict'

require! fs
require! jade

view-path = (view-name) ->
  'source/views/' + view-name + '.jade'

write-html = (view, options, file) ->
  file = file + '.html'
  jade.render-file view, options, (err, html) ->
    fs.write-file file, html, (err) ->
      if err
        console.error err
      else
        console.log "#{file} saved"

write-json = (db, path) ->
  file = path + '.json'
  data = JSON.stringify db, null, 2
  fs.write-file file, data, (err) ->
    if err
      console.log err
    else
      console.log "#{file} saved"

exports.view-path = view-path
exports.write-html = write-html
exports.write-json = write-json
