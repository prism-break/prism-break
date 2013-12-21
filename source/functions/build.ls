'use strict'

# libraries
require! mkdirp
require! '../functions/helpers.ls'
{select-random, slugify-db, slugify-project, subcategories-of, images-in, in-this-category, in-this-subcategory, in-these-subcategories, in-this-protocol, nested-categories, platform-types, protocol-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'
{routes} = require '../functions/routes.ls'

# data
{projects-raw} = require '../db/en-projects.ls'
{projects-rejected-raw} = require '../db/en-projects-rejected.ls'
{platform-types} = require '../db/en-platform-types.ls'
{protocols-raw} = require '../db/en-protocols.ls'
i18n = require '../i18n/index.ls'

# slugging the data for urls
projects-db = slugify-db projects-raw
projects-rejected-db = slugify-db projects-rejected-raw
protocols-db = slugify-db protocols-raw


############################################################################
# WRITE FUNCTIONS
# These functions write all of the HTML pages for the entire site.

write-localized-site = (iso639, locale) ->
  dir = "public/#{iso639}/"
  mkdirp dir

  write-site-index dir, locale
  write-categories-index dir, locale
  write-categories-show dir, locale
  write-subcategories-show dir, locale
  write-protocols-index dir, locale
  write-protocols-show dir, locale
  write-projects-index dir, locale
  write-projects-show dir, locale
  write-about-index dir
  write-about-media dir

write-site-index = (dir, locale) ->
  data = platform-types projects-db

  path = 'index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso639} root index"
    h: helpers
    platform-types: data
    path: ''
    routes: routes!
    t: locale
  file = dir + path

  write-html view, options, file
  write-json data, file

write-categories-index = (dir) ->
  data = nested-categories projects-db

  path = 'categories/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso639} categories index"
    h: helpers
    categories: data
    path: 'categories'
    routes: routes 'categories', 1
    language: iso639
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

write-categories-show = (dir, locale) ->
  create = (category) ->
    data = category

    path = "categories/#{category.slug}/"
    view = view-path 'categories/show'
    options = 
      pretty: true
      body-class: "#{iso639} categories show"
      h: helpers
      category: category
      platform-types: platform-types projects-db
      path: path
      routes: routes 'categories', 2
      language: iso639
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

  for category in nested-categories(projects-db)
    create category

write-subcategories-show = (dir, locale) ->
  create = (subcategory) ->
    data =
      category: category
      subcategory: subcategory
      projects: in-this-subcategory(subcategory.name, in-this-category(category.name, projects-db))
      projects-rejected: in-this-subcategory(subcategory.name, in-this-category(category.name, projects-rejected-raw))

    path = "subcategories/#{category.slug}-#{subcategory.slug}/"
    view = view-path 'subcategories/show'
    options = 
      pretty: true
      body-class: "#{iso639} subcategories show"
      h: helpers
      data: data
      path: path
      routes: routes 'subcategories', 2
      language: iso639
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

  for category in nested-categories(projects-db)
    for subcategory in category.subcategories
      create subcategory

write-protocols-index = (dir, locale) ->
  data = protocol-types protocols-db

  path = 'protocols/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso639} protocols index"
    h: helpers
    protocol-types: data
    path: 'protocols'
    routes: routes 'protocols', 1
    language: iso639
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

write-protocols-show = (dir, locale) ->
  create = (protocol) ->
    protocol.projects = in-this-protocol(protocol.name, projects-db)
    data = protocol

    path = "protocols/#{protocol.slug}/"
    view = view-path 'protocols/show'
    options = 
      pretty: true
      body-class: "#{iso639} protocols show"
      h: helpers
      protocol: data
      protocol-types: protocol-types protocols-db
      path: path
      routes: routes 'protocols', 2
      language: iso639
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

  for protocol in protocols-db
    create protocol

write-projects-index = (dir, locale) ->
  data = projects-db

  path = 'projects/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{iso639} projects index"
    h: helpers
    projects: data
    path: 'projects'
    routes: routes 'projects', 1
    language: iso639
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

write-projects-show = (dir, locale) ->
  create = (project) ->
    data = slugify-project project
    #data.projects-related = in-these-subcategories(subcategories-of(project), projects-db)

    path = "projects/#{project.slug}/"
    view = view-path 'projects/show'
    options = 
      pretty: true
      body-class: "#{iso639} projects show"
      h: helpers
      project: data
      routes: routes 'projects', 2
      language: iso639
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

  for project in projects-db
    create project

write-about-index = (dir) ->
  create = ->
    path = 'about/index'
    view = view-path path
    options =
      pretty: true
      body-class: "#{iso639} about index"
      h: helpers
      path: 'about'
      routes: routes 'about', 1
      language: iso639
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

write-about-media = (dir) ->
  create = ->
    path = 'about/media/'
    view = view-path 'about/media'
    options =
      pretty: true
      body-class: "#{iso639} about media"
      h: helpers
      path: path
      routes: routes 'about', 2
      language: iso639
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
# This function will write all of the HTML pages per site iso639.


# exports.write-localized-site = write-localized-site

for iso639, locale of i18n
  write-localized-site(iso639, locale)
