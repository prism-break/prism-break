'use strict'

# libraries
require! mkdirp
require! '../functions/helpers.ls'
{select-random, slugify-db, slugify-project, subcategories-of, images-in, in-this-category, in-this-subcategory, in-these-subcategories, in-this-protocol, nested-categories, platform-types, protocol-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'
{routes} = require '../functions/routes.ls'


############################################################################
# WRITE FUNCTIONS
# These functions write all of the HTML pages for the entire site.

write-localized-site = (iso, locale, data) ->
  dir = "public/#{iso}/"
  mkdirp dir

  db =
    projects-db: slugify-db data.projects-raw
    projects-rejected-raw: data.projects-rejected-raw
    protocols-db: slugify-db data.protocols-raw
    platform-types: data.platform-types

  write-site-index dir, iso, locale, db
  write-categories-index dir, iso, locale, db
  write-categories-show dir, iso, locale, db
  write-subcategories-show dir, iso, locale, db
  write-protocols-index dir, iso, locale, db
  write-protocols-show dir, iso, locale, db
  write-projects-index dir, iso, locale, db
  write-projects-show dir, iso, locale, db
  write-about-index dir, iso, locale
  write-about-media dir, iso, locale

write-site-index = (dir, iso, locale, db) ->
  data = db.platform-types db.projects-db

  path = 'index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso} root index"
    h: helpers
    platform-types: data
    path: ''
    routes: routes!
    t: locale
  file = dir + path

  write-html view, options, file
  write-json data, file

write-categories-index = (dir, iso, locale, db) ->
  data = nested-categories db.projects-db

  path = 'categories/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso} categories index"
    h: helpers
    categories: data
    path: 'categories'
    routes: routes 'categories', 1
    language: iso
    t: locale
  file = dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp dir + 'categories', (err) ->
    if err
      console.error err
    else
      write!

write-categories-show = (dir, iso, locale, db) ->
  create = (category) ->
    data = category

    path = "categories/#{category.slug}/"
    view = view-path 'categories/show'
    options = 
      pretty: true
      body-class: "#{iso} categories show"
      h: helpers
      category: category
      platform-types: db.platform-types db.projects-db
      path: path
      routes: routes 'categories', 2
      language: iso
      t: locale
    full-path = dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories(db.projects-db)
    create category

write-subcategories-show = (dir, iso, locale, db) ->
  create = (subcategory) ->
    data =
      category: category
      subcategory: subcategory
      projects: in-this-subcategory(subcategory.name, in-this-category(category.name, db.projects-db))
      projects-rejected: in-this-subcategory(subcategory.name, in-this-category(category.name, db.projects-rejected-raw))

    path = "subcategories/#{category.slug}-#{subcategory.slug}/"
    view = view-path 'subcategories/show'
    options = 
      pretty: true
      body-class: "#{iso} subcategories show"
      h: helpers
      data: data
      path: path
      routes: routes 'subcategories', 2
      language: iso
      t: locale
    full-path = dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories(db.projects-db)
    for subcategory in category.subcategories
      create subcategory

write-protocols-index = (dir, iso, locale, db) ->
  data = protocol-types db.protocols-db

  path = 'protocols/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso} protocols index"
    h: helpers
    protocol-types: data
    path: 'protocols'
    routes: routes 'protocols', 1
    language: iso
    t: locale
  file = dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp dir + 'protocols', (err) ->
    if err
      console.error err
    else
      write!

write-protocols-show = (dir, iso, locale, db) ->
  create = (protocol) ->
    protocol.projects = in-this-protocol(protocol.name, db.projects-db)
    data = protocol

    path = "protocols/#{protocol.slug}/"
    view = view-path 'protocols/show'
    options = 
      pretty: true
      body-class: "#{iso} protocols show"
      h: helpers
      protocol: data
      protocol-types: protocol-types db.protocols-db
      path: path
      routes: routes 'protocols', 2
      language: iso
      t: locale
    full-path = dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for protocol in db.protocols-db
    create protocol

write-projects-index = (dir, iso, locale, db) ->
  data = db.projects-db

  path = 'projects/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso} projects index"
    h: helpers
    projects: data
    path: 'projects'
    routes: routes 'projects', 1
    language: iso
    t: locale
  file = dir + path

  write = ->
    write-html view, options, file
    write-json data, file

  mkdirp dir + 'projects', (err) ->
    if err
      console.error err
    else
      write!

write-projects-show = (dir, iso, locale, db) ->
  create = (project) ->
    data = slugify-project project
    #data.projects-related = in-these-subcategories(subcategories-of(project), db.projects-db)

    path = "projects/#{project.slug}/"
    view = view-path 'projects/show'
    options = 
      pretty: true
      body-class: "#{iso} projects show"
      h: helpers
      project: data
      routes: routes 'projects', 2
      language: iso
      t: locale
      path: path
    full-path = dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file
      write-json data, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for project in db.projects-db
    create project

write-about-index = (dir, iso, locale, db) ->
  create = ->
    path = 'about/index'
    view = view-path path
    options =
      pretty: true
      body-class: "#{iso} about index"
      h: helpers
      path: 'about'
      routes: routes 'about', 1
      language: iso
      t: locale
    file = dir + path

    write = ->
      write-html view, options, file

    mkdirp dir + 'about', (err) ->
      if err
        console.error err
      else
        write!

  create!

write-about-media = (dir, iso, locale, db) ->
  create = ->
    path = 'about/media/'
    view = view-path 'about/media'
    options =
      pretty: true
      body-class: "#{iso} about media"
      h: helpers
      path: path
      routes: routes 'about', 2
      language: iso
      t: locale
    full-path = dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  create!

############################################################################
# WRITE SITE
# This function will write all of the HTML pages per site iso.

exports.write-localized-site = write-localized-site
