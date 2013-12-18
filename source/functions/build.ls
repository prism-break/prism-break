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


write-site-index = (translation) ->
  data = platform-types projects-db

  path = 'index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{language} root index"
    h: helpers
    platform-types: data
    path: ''
    routes: routes!
    t: translation
  file = public-dir + path

  write-html view, options, file
  write-json data, file

write-categories-index = ->
  data = nested-categories projects-db

  path = 'categories/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{language} categories index"
    h: helpers
    categories: data
    path: 'categories'
    routes: routes 'categories', 1
    language: language
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
    data = category

    path = "categories/#{category.slug}/"
    view = view-path 'categories/show'
    options = 
      pretty: true
      body-class: "#{language} categories show"
      h: helpers
      category: category
      platform-types: platform-types projects-db
      routes: routes 'categories', 2
      language: language
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

  for category in nested-categories(projects-db)
    create category

write-subcategories-show = (translation) ->
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
      body-class: "#{language} subcategories show"
      h: helpers
      data: data
      routes: routes 'subcategories', 2
      language: language
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

  for category in nested-categories(projects-db)
    for subcategory in category.subcategories
      create subcategory

write-protocols-index = (translation) ->
  data = protocol-types protocols-db

  path = 'protocols/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{language} protocols index"
    h: helpers
    protocol-types: data
    routes: routes 'protocols', 1
    language: language
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
    protocol.projects = in-this-protocol(protocol.name, projects-db)
    data = protocol

    path = "protocols/#{protocol.slug}/"
    view = view-path 'protocols/show'
    options = 
      pretty: true
      body-class: "#{language} protocols show"
      h: helpers
      protocol: data
      protocol-types: protocol-types protocols-db
      routes: routes 'protocols', 2
      language: language
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

  for protocol in protocols-db
    create protocol

write-projects-index = (translation) ->
  data = projects-db

  path = 'projects/index'
  view = view-path path
  options = 
    pretty: true
    body-class: "#{language} projects index"
    h: helpers
    projects: data
    routes: routes 'projects', 1
    language: language
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
    data = slugify-project project
    #data.projects-related = in-these-subcategories(subcategories-of(project), projects-db)

    path = "projects/#{project.slug}/"
    view = view-path 'projects/show'
    options = 
      pretty: true
      body-class: "#{language} projects show"
      h: helpers
      project: data
      routes: routes 'projects', 2
      language: language
      t: translation
      path: path
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

  for project in projects-db
    create project

write-about-index = ->
  create = ->
    path = 'about/index'
    view = view-path path
    options =
      pretty: true
      body-class: "#{language} about index"
      h: helpers
      routes: routes 'about', 1
      language: language
      t: translation
    file = public-dir + path

    write = ->
      write-html view, options, file

    mkdirp public-dir + 'about', (err) ->
      if err
        console.error err
      else
        write!

  create!

write-about-media = ->
  create = ->
    path = 'about/media/'
    view = view-path 'about/media'
    options =
      pretty: true
      body-class: "#{language} about media"
      h: helpers
      routes: routes 'about', 2
      language: language
      t: translation
    full-path = public-dir + path
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
# This function will write all of the HTML pages per site language.


for language, translation of i18n

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
  write-about-index!
  write-about-media!
