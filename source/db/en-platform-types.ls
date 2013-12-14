{slugify-list} = require '../functions/sort.ls'

platform-types = (db) ->
  types =
    * name: 'Services'
      slug: 'services'
      categories: ['Services']
    * name: 'Mobile'
      slug: 'mobile'
      categories: ['Android', 'iOS']
    * name: 'PC'
      slug: 'pc'
      categories: ['BSD', 'Linux', 'Mac OS X', 'Windows']
    * name: 'Server'
      slug: 'server'
      categories: ['Routers', 'Servers']

  for type in types
    type.categories = slugify-list type.categories
  types

exports.platform-types = platform-types
