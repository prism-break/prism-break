{filter, flatten, map, sort, sort-by, unique, values} = require 'prelude-ls'
{slugify} = require './slugify.ls'

slugify-db = (db) ->
  list = db
  for project in list
    project.slug = slugify project.name
    project.protocols-slugged = slugify-list project.protocols
  list = sort-by (.name), list

slugify-list = (list) ->
  map (-> { name: it, slug: slugify(it)}), list

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

protocols-in = (db) ->
  list = map (.protocols), db
  list = unique flatten list
  list = sort slugify-list list

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

in-this-protocol = (protocol, db) ->
  filter (-> protocol in it.protocols), db

categories-tree = (db) ->
  tree = categories-in db
  for category in tree
    category.protocols = protocols-in(in-this-category(category.name, db))
    category.protocols = sort-by (.name), category.protocols
  tree = sort-by (.name), tree

nested-categories = (db) ->
  tree = categories-in db
  for category in tree
    category.subcategories = subcategories-in(category.name, in-this-category(category.name, db))
    category.subcategories = sort-by (.name), category.subcategories
  tree = sort-by (.name), tree

protocols-tree =  (db) ->
  tree = protocols-in(db)
  for protocol in tree
    protocol.projects = in-this-protocol(protocol.name, db)
  tree = sort-by (.name), tree


exports.slugify-db = slugify-db
exports.slugify-list = slugify-list
exports.categories-in = categories-in
exports.subcategories-in = subcategories-in
exports.protocols-in = protocols-in
exports.in-this-category = in-this-category
exports.in-this-subcategory = in-this-subcategory
exports.in-this-protocol = in-this-protocol
exports.categories-tree = categories-tree
exports.nested-categories = nested-categories
exports.protocols-tree = protocols-tree
