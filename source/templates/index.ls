'use strict'

# libraries
require! fs
require! mkdirp
{slugify-db, subcategories-in, protocols-in, in-this-category, in-this-subcategory, in-this-protocol, categories-tree, nested-categories, protocols-tree} = require '../functions/sort.ls'
{tmpl, routes, write-html, write-json} = require '../functions/paths.ls'

# data
{data} = require '../data/en-projects.ls'
translations = require '../translations'

# the main database
database = slugify-db data


############################################################################
# WRITE
# The following code writes all of the HTML pages for the entire site.


for language, translation of translations

  public-dir = "public/#{language}/"
  mkdirp public-dir

  # WRITE site/index
  do ->
    data = nested-categories(database)

    path = 'index'
    template = tmpl path
    options = 
      pretty: true
      table: data
      routes: routes!
      t: translation
    file = public-dir + path

    write-html template, options, file
    write-json data, file

  # WRITE categories/index
  do ->
    data = nested-categories(database)

    path = 'categories/index'
    template = tmpl path
    options = 
      pretty: true
      table: nested-categories(database)
      routes: routes 'categories', 1
      t: translation
    file = public-dir + path

    write = ->
      write-html template, options, file
      write-json data, file

    mkdirp public-dir + 'categories', (err) ->
      if err
        console.error err
      else
        write!

  # WRITE categories/show
  do ->
    create = (category) ->
      data = subcategories-in(category.name, database)

      path = "categories/#{category.slug}/"
      template = tmpl 'categories/show'
      options = 
        pretty: true
        category: category
        table: data
        routes: routes 'categories', 2
        t: translation
      full-path = public-dir + path
      file = full-path + 'index'

      write = ->
        write-html template, options, file
        write-json data, file

      mkdirp full-path, (err) ->
        if err
          console.error err
        else
          write!

    for category in nested-categories(database)
      create category

  # WRITE subcategories/show
  do ->
    create = (subcategory) ->
      data = in-this-subcategory(subcategory.name, in-this-category(category.name, database))

      path = "subcategories/#{category.slug}-#{subcategory.slug}/"
      template = tmpl 'subcategories/show'
      options = 
        pretty: true
        category: category
        category-file: "../../categories/#{category.slug}"
        subcategory: subcategory
        table: data
        routes: routes 'subcategories', 2
        t: translation
      full-path = public-dir + path
      file = full-path + 'index'

      write = ->
        write-html template, options, file
        write-json data, file

      mkdirp full-path, (err) ->
        if err
          console.error err
        else
          write!

    for category in nested-categories(database)
      for subcategory in category.subcategories
        create subcategory

  # WRITE protocols/index
  do ->
    data = protocols-tree(database)

    path = 'protocols/index'
    template = tmpl path
    options = 
      pretty: true
      table: data
      routes: routes 'protocols', 1
      t: translation
    file = public-dir + path

    write = ->
      write-html template, options, file
      write-json data, file

    mkdirp public-dir + 'protocols', (err) ->
      if err
        console.error err
      else
        write!

  # WRITE protocols/show
  do ->
    create = (protocol) ->
      data = protocol

      path = "protocols/#{protocol.slug}/"
      template = tmpl 'protocols/show'
      options = 
        pretty: true
        protocol: data
        table: in-this-protocol(protocol.name, database)
        routes: routes 'protocols', 2
        t: translation
      full-path = public-dir + path
      file = full-path + 'index'

      write = ->
        write-html template, options, file
        write-json data, file

      mkdirp full-path, (err) ->
        if err
          console.error err
        else
          write!

    for protocol in protocols-in(database)
      create protocol

  # WRITE projects/index
  do ->
    data = database

    path = 'projects/index'
    template = tmpl path
    options = 
      pretty: true
      table: data
      routes: routes 'projects', 1
      t: translation
    file = public-dir + path

    write = ->
      write-html template, options, file
      write-json data, file

    mkdirp public-dir + 'projects', (err) ->
      if err
        console.error err
      else
        write!

  # WRITE projects/show
  do ->

    create = (project) ->

      path = "projects/#{project.slug}/"
      template = tmpl 'projects/show'
      options = 
        pretty: true
        project: project
        routes: routes 'projects', 2
        t: translation
      full-path = public-dir + path
      file = full-path + 'index'

      write = ->
        write-html template, options, file
        write-json data, file

      mkdirp full-path, (err) ->
        if err
          console.error err
        else
          write!

    for project in database
      create project


