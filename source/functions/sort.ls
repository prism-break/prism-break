{filter, flatten, map, sort, sort-by, unique, values} = require 'prelude-ls'
{slugify} = require './slugify.ls'

slugify-db = (db) ->
  list = db
  for city in list
    city.slug = slugify city.name
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

countries-in = (db) ->
  list = map (.country), db
  list = unique flatten list
  list = sort slugify-list list

in-this-category = (category-name, db) ->
  list = []
  for city in db
    for category in city.categories
      if category.name == category-name
        list.push city
  list = unique list

in-this-subcategory = (subcategory-name, db) ->
  list = []
  for city in db
    for category in city.categories
      for subcategory in category.subcategories
        if subcategory == subcategory-name
          list.push city
  list = unique list

in-this-country = (country, db) ->
  filter (-> country == it.country), db

categories-tree = (db) ->
  tree = categories-in db
  for category in tree
    category.countries = countries-in(in-this-category(category.name, db))
    category.countries = sort-by (.name), category.countries
  tree = sort-by (.name), tree

nested-categories = (db) ->
  tree = categories-in db
  for category in tree
    category.subcategories = subcategories-in(category.name, in-this-category(category.name, db))
    category.subcategories = sort-by (.name), category.subcategories
  tree = sort-by (.name), tree

countries-tree =  (db) ->
  tree = countries-in(db)
  for country in tree
    country.cities = in-this-country(country.name, db)
  tree = sort-by (.name), tree


exports.slugify-db = slugify-db
exports.slugify-list = slugify-list
exports.categories-in = categories-in
exports.subcategories-in = subcategories-in
exports.countries-in = countries-in
exports.in-this-category = in-this-category
exports.in-this-subcategory = in-this-subcategory
exports.in-this-country = in-this-country
exports.categories-tree = categories-tree
exports.nested-categories = nested-categories
exports.countries-tree = countries-tree
