'use strict'

require! fs
require! jade

view-path = (view-name) ->
  'source/views/' + view-name + '.jade'

routes = (subdirectory, depth)->
  if depth?
    if depth == 0
      prefix = './'
    else if depth == 1
      prefix = '../'
    else if depth == 2
      prefix = '../../'
    else
      console.log "depth only goes to 2"
  else
    prefix = './'

  bare-paths =
    css: '../assets/css/screen.css'
    root: ''
    categories: 'categories'
    projects: 'projects'
    protocols: 'protocols'
    platforms: 'platforms'
    platform-types: 'platform-types'
    images: '../assets/img'
    logos: '../assets/img/logos/medium/'

  final-paths = {}
  for key, value of bare-paths
    if subdirectory == value
      if depth == 2
        final-paths[key] = '../'
      else
        final-paths[key] = './'
    else
      final-paths[key] = prefix + value
  final-paths

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
exports.routes = routes
exports.write-html = write-html
exports.write-json = write-json
