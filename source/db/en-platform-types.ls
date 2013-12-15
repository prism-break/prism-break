{slugify-list} = require '../functions/sort.ls'

platform-types = (db) ->
  types =
    * name: 'Services'
      categories: ['Web Services']
    * name: 'Mobile'
      categories: ['Android', 'iOS']
    * name: 'Computer'
      categories: ['BSD', 'Linux', 'Mac OS X', 'Windows']
    * name: 'Server'
      categories: ['Routers', 'Servers']

  for type in types
    type.categories = slugify-list type.categories
  types

exports.platform-types = platform-types
