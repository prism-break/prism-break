{platform-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'

write-site-index = (translation) ->
  data = platform-types projects-db

  path = 'index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{language} root index"
    h: helpers
    platform-types: data
    routes: routes!
    t: translation
  file = public-dir + path

  write-html view, options, file
  write-json data, file

for language, translation of i18n

  t = translation
  public-dir = "public/#{language}/"
  mkdirp public-dir

  write-site-index translation
