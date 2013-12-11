'use strict'

require! fs

tmpl = (template-name) ->
  template = 'source/templates/' + template-name + '.jade'

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
    protocols: 'protocols'
    projects: 'projects'
    images: '../../images'
    logos: '../../images/logos/medium/'

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

write-json = (db, path) ->
  file = path + '.json'
  data = JSON.stringify db, null, 2
  fs.write-file file, data, (err) ->
    if err
      console.log err
    else
      console.log "#{file} saved"

exports.tmpl = tmpl
exports.routes = routes
exports.write-json = write-json
