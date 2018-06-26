{slugify} = require '../functions/slugify.ls'

exports.platform-types = (db) ->
  types =
    * name: 'Mobile'
      categories: [
        * name: 'Android'
          fa: 'fa-android'
        * name: 'iOS'
          fa: 'fa-mobile'
      ]
    * name: 'Computer'
      categories: [
        * name: 'BSD'
          fa: 'fa-lock'
        * name: 'GNU/Linux'
          fa: 'fa-linux'
        * name: 'macOS'
          fa: 'fa-apple'
        * name: 'Windows'
          fa: 'fa-windows'
      ]
    * name: 'Network'
      categories: [
        * name: 'Routers'
          fa: 'fa-sitemap'
        * name: 'Servers'
          fa: 'fa-tasks'
      ]

  for type in types
    for category in type.categories
      category.slug = slugify category.name
  types
