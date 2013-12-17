{flatten, take, unique} = require 'prelude-ls'
{images-in, in-this-category, shuffle-array, slugify-list} = require '../functions/sort.ls'

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
    for category in type.categories
      category.projects = in-this-category(category.name, db)
      category.logos = images-in(category.projects)
      category.logos = take 5 (unique flatten category.logos)
  types

exports.platform-types = platform-types
