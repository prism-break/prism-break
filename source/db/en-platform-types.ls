{flatten, take, unique} = require 'prelude-ls'
{images-in, in-this-category, shuffle-array} = require '../functions/sort.ls'
{slugify} = require '../functions/slugify.ls'


platform-types = (db) ->
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
        * name: 'OS X'
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
      #category.projects = in-this-category(category.name, db)
      #category.logos = images-in(category.projects)
      #category.logos = take 5 (unique flatten category.logos)
  types

exports.platform-types = platform-types
