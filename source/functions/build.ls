'use strict'

# libraries
require! mkdirp
require! marked
{truncate} = require '../functions/truncate.ls'
{slugify-db, subcategories-in, protocols-in, in-this-category, in-this-subcategory, in-this-protocol, categories-tree, nested-categories, protocols-tree, platform-types} = require '../functions/sort.ls'
{view-path, routes, write-html, write-json} = require '../functions/paths.ls'

# data
{data} = require '../db/en-projects.ls'
{platform-types} = require '../db/en-platform-types.ls'
{protocol-types} = require '../db/en-protocol-types.ls'
translations = require '../i18n/index.ls'

# the main database
database = slugify-db data


############################################################################
# WRITE FUNCTIONS
# These functions write all of the HTML pages for the entire site.


write-site-index = (translation) ->
  data = platform-types database

  path = 'index'
  view = view-path path
  options = 
    pretty: true
    platform-types: data
    routes: routes!
    t: translation
  file = public-dir + path

  write-html view, options, file
  write-json data, file

write-categories-index = ->
  data = nested-categories(database)

  path = 'categories/index'
  view = view-path path
  options = 
    pretty: true
    categories: data
    routes: routes 'categories', 1
    t: translation
  file = public-dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp public-dir + 'categories', (err) ->
    if err
      console.error err
    else
      write!

write-categories-show = (translation) ->
  create = (category) ->
    category.subcategories = subcategories-in(category.name, database)
    data = category

    path = "categories/#{category.slug}/"
    view = view-path 'categories/show'
    options = 
      pretty: true
      category: category
      routes: routes 'categories', 2
      t: translation
    full-path = public-dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories(database)
    create category

write-subcategories-show = (translation) ->
  create = (subcategory) ->
    data =
      category: category
      subcategory: subcategory
      projects: in-this-subcategory(subcategory.name, in-this-category(category.name, database))

    path = "subcategories/#{category.slug}-#{subcategory.slug}/"
    view = view-path 'subcategories/show'
    options = 
      pretty: true
      data: data
      routes: routes 'subcategories', 2
      t: translation
    full-path = public-dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories(database)
    for subcategory in category.subcategories
      create subcategory

write-protocols-index = (translation) ->
  data = protocol-types database

  path = 'protocols/index'
  view = view-path path
  options = 
    pretty: true
    protocol-types: data
    routes: routes 'protocols', 1
    t: translation
  file = public-dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp public-dir + 'protocols', (err) ->
    if err
      console.error err
    else
      write!

write-protocols-show = (translation) ->
  create = (protocol) ->
    protocol.projects = in-this-protocol(protocol.name, database)
    data = protocol

    path = "protocols/#{protocol.slug}/"
    view = view-path 'protocols/show'
    options = 
      pretty: true
      protocol: data
      routes: routes 'protocols', 2
      t: translation
    full-path = public-dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for protocol in protocols-in(database)
    create protocol

write-projects-index = (translation) ->
  data = database

  path = 'projects/index'
  view = view-path path
  options = 
    pretty: true
    truncate: truncate
    projects: data
    routes: routes 'projects', 1
    t: translation
  file = public-dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp public-dir + 'projects', (err) ->
    if err
      console.error err
    else
      write!

write-projects-show = (translation) ->
  create = (project) ->
    data = project

    path = "projects/#{project.slug}/"
    view = view-path 'projects/show'
    options = 
      pretty: true
      marked: marked
      project: data
      routes: routes 'projects', 2
      t: translation
    full-path = public-dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for project in database
    create project


############################################################################
# WRITE SITE
# This function will write all of the HTML pages per site language.


for language, translation of translations

  t = translation
  public-dir = "public/#{language}/"
  mkdirp public-dir

  write-site-index translation
  write-categories-index translation
  write-categories-show translation
  write-subcategories-show translation
  write-protocols-index translation
  write-protocols-show translation
  write-projects-index translation
  write-projects-show translation
