{filter, flatten, map, sort, sort-by, unique, values} = require 'prelude-ls'
{slugify} = require './slugify.ls'

export slugify-db = (db) ->
  list = db
  for project in list
    project.slug = slugify project.name
    project.categories = sort-by (.name.to-lower-case!), project.categories
  list = sort-by (.name.to-lower-case!), list

export slugify-list = (list) ->
  map (-> { name: it, slug: slugify(it)}), list

export slugify-project = (project) ->
  if project.protocols?
    project.protocols-slugged = slugify-list project.protocols
  if project.categories?
    for category in project.categories
      category.slug = slugify category.name
      category.subcategories = slugify-list category.subcategories
  project

export categories-in = (db) ->
  list = flatten map (.categories), db
  list = map (.name), list
  list = unique list
  list = slugify-list list
  list = sort-by (.name.to-lower-case!), list

export subcategories-in = (category-name, db) ->
  list = flatten map (.categories), db
  list = filter (.name == category-name), list
  list = map (.subcategories), list
  list = unique flatten list
  list = slugify-list list
  list = sort-by (.name.to-lower-case!), list

export subcategories-in-raw = (category-name, db) ->
  list = flatten map (.categories), db
  list = filter (.name == category-name), list
  list = map (.subcategories), list
  list = unique flatten list

subcategories-all = (db) ->
  tree = categories-in db
  subcategories = []
  for category in tree
    category.subcategories = subcategories-in(category.name, in-this-category(category.name, db))
    for subcategory in category.subcategories
      subcategories.push subcategory.name
  subcategories = sort-by (.to-lower-case!), unique subcategories

export nested-subcategories = (db, rejected) ->
  tree = slugify-list subcategories-all db
  tree = map ((it) -> name: it.name, slug: it.slug, projects: in-this-subcategory(it.name, db), projects-rejected: in-this-subcategory(it.name, rejected)), tree
  tree = unique tree

export in-this-category = (category-name, db) ->
  list = []
  for project in db
    for category in project.categories
      if category.name == category-name
        list.push project
  list = unique list

export in-this-subcategory = (subcategory-name, db) ->
  list = []
  for project in db
    for category in project.categories
      for subcategory in category.subcategories
        if subcategory == subcategory-name
          list.push project
  list = unique list

export in-this-protocol = (protocol, db) ->
  filter (-> protocol in it.protocols), db

export nested-categories-web = (db) ->
  tree = categories-in db
  for category in tree
    if category.name in <[Routers Servers]>
      category.subcategories = subcategories-in(category.name, in-this-category(category.name, db))
      category.subcategories = sort-by (.name.to-lower-case!), category.subcategories

      for subcategory in category.subcategories
        subcategory.projects = in-this-subcategory(subcategory.name, in-this-category(category.name, db))
        subcategory.projects = sort-by (.name.to-lower-case!), subcategory.projects
    else
      cat-subcategories = subcategories-in-raw(category.name, in-this-category(category.name, db))
      web-subcategories = subcategories-in-raw('Web Services', in-this-category('Web Services', db))
      all-subcategories = slugify-list unique cat-subcategories.concat web-subcategories
      category.subcategories = all-subcategories
      category.subcategories = sort-by (.name.to-lower-case!), category.subcategories

      for subcategory in category.subcategories
        cat-projects = in-this-subcategory(subcategory.name, in-this-category(category.name, db))
        web-projects = in-this-subcategory(subcategory.name, in-this-category('Web Services', db))
        all-projects = sort-by((.name.to-lower-case!), unique(cat-projects.concat(web-projects)))
        subcategory.projects = all-projects
  tree = sort-by (.name.to-lower-case!), tree

export protocol-types = (protocols) ->
  types = categories-in protocols
  for type in types
    type.protocols = in-this-category(type.name, protocols)
  types
