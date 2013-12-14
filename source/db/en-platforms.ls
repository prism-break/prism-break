{slugify-list} = require '../functions/sort.ls'

platforms = (db) ->
  platform-types =
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

  for platform in platform-types
    platform.categories = slugify-list platform.categories
  platform-types

exports.platforms = platforms
