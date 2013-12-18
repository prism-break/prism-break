{filter, flatten, map, sort, sort-by, unique, values} = require 'prelude-ls'
{slugify} = require './slugify.ls'

select-random = (list) ->
  list[Math.floor(Math.random! * list.length)]

slugify-db = (db) ->
  list = db
  for project in list
    project.slug = slugify project.name
    project.categories = sort-by (.name), project.categories
  list = sort-by (.name), list

slugify-list = (list) ->
  map (-> { name: it, slug: slugify(it)}), list

slugify-project = (project) ->
  if project.protocols?
    project.protocols-slugged = slugify-list project.protocols
  if project.categories?
    for category in project.categories
      category.slug = slugify category.name
      category.subcategories = slugify-list category.subcategories
  project

categories-in = (db) ->
  list = flatten map (.categories), db
  list = map (.name), list
  list = unique list
  list = slugify-list list
  list = sort-by (.name), list

subcategories-in = (category-name, db) ->
  list = flatten map (.categories), db
  list = filter (.name == category-name), list
  list = map (.subcategories), list
  list = unique flatten list
  list = slugify-list list
  list = sort-by (.name), list

subcategories-of = (project) ->
  list = flatten map (.subcategories), project.categories
  list = map (.name), list
  list = unique flatten list
  list = sort list

images-in = (db) ->
  list = map (.logo), db

in-this-category = (category-name, db) ->
  list = []
  for project in db
    for category in project.categories
      if category.name == category-name
        list.push project
  list = unique list

in-this-subcategory = (subcategory-name, db) ->
  list = []
  for project in db
    for category in project.categories
      for subcategory in category.subcategories
        if subcategory == subcategory-name
          list.push project
  list = unique list

in-these-subcategories = (subcategories, db) ->
  list = []
  for subcategory in subcategories
    list.push in-this-subcategory(subcategory, db)
  list = unique list

in-this-protocol = (protocol, db) ->
  filter (-> protocol in it.protocols), db

nested-categories = (db) ->
  tree = categories-in db
  for category in tree
    category.subcategories = subcategories-in(category.name, in-this-category(category.name, db))
    category.subcategories = sort-by (.name), category.subcategories
    for subcategory in category.subcategories
      subcategory.projects = in-this-subcategory(subcategory.name, in-this-category(category.name, db))
      subcategory.project-logos = images-in(subcategory.projects)
      subcategory.random-logo = select-random(subcategory.project-logos)
  tree = sort-by (-> it.name.to-lower-case!), tree

protocol-types = (protocols) ->
  types = categories-in protocols
  for type in types
    type.protocols = in-this-category(type.name, protocols)
  types

exports.select-random = select-random
exports.shuffle-array = select-random
exports.slugify-db = slugify-db
exports.slugify-list = slugify-list
exports.slugify-project = slugify-project
exports.categories-in = categories-in
exports.subcategories-in = subcategories-in
exports.subcategories-of = subcategories-of
exports.images-in = images-in
exports.in-this-category = in-this-category
exports.in-this-subcategory = in-this-subcategory
exports.in-these-subcategories = in-these-subcategories
exports.in-this-protocol = in-this-protocol
exports.nested-categories = nested-categories
exports.protocol-types = protocol-types
