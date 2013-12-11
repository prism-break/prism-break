'use strict'

# libraries
require! mkdirp
{slugify-db, subcategories-in, protocols-in, in-this-subcategory, in-this-protocol, categories-tree, nested-categories, protocols-tree} = require '../functions/sort.ls'
{tmpl, routes, write-html, write-json} = require '../functions/paths.ls'

# data
{data} = require '../data/software-en.ls'
translations = require '../translations'

# the main database
database = slugify-db data


############################################################################
#
# WRITE
# The following code writes all of the HTML pages for the entire site.
#
############################################################################


for language, translation of translations

  public-dir = "public/#{language}/"
  mkdirp public-dir

  # WRITE site/index
  do ->
    data = nested-categories(database)
    path = 'index'
    file = public-dir + path
    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes!
      t: translation

    write-html template, options, file
    write-json data, file

  # WRITE categories/index
  do ->
    data = nested-categories(database)
    path = 'categories/index'
    file = public-dir + path
    template = tmpl path

    options = 
      pretty: true
      table: nested-categories(database)
      routes: routes 'categories', 1
      t: translation

    write-html template, options, file
    write-json data, file

  # WRITE categories/show
  do ->
    for category in nested-categories(database)
      data = subcategories-in(category.name, database)
      path = "categories/#{category.slug}/"
      full-path = public-dir + path
      file = full-path + 'index'
      template = tmpl "categories/show"

      mkdirp full-path

      options = 
        pretty: true
        category: category
        table: data
        routes: routes 'categories', 2
        t: translation

      write-html template, options, file
      write-json data, file

  # WRITE subcategories/show
  do ->
    for category in nested-categories(database)
      for subcategory in category.subcategories
        data = in-this-subcategory(subcategory.name, database)
        path = "subcategories/#{category.slug}-#{subcategory.slug}/"
        full-path = public-dir + path
        file = full-path + 'index'
        template = tmpl "subcategories/show"

        mkdirp full-path

        options = 
          pretty: true
          category: category
          category-file: "../../categories/#{category.slug}"
          subcategory: subcategory
          table: data
          routes: routes 'subcategories', 2
          t: translation

        write-html template, options, file
        write-json data, file

  # WRITE protocols/index
  do ->
    data = protocols-tree(database)
    path = 'protocols/index'
    file = public-dir + path
    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes 'protocols', 1
      t: translation

    write-html template, options, file
    write-json data, file

  # WRITE protocols/show
  do ->
    for protocol in protocols-in(database)
      data = protocol
      path = "protocols/#{protocol.slug}/"
      full-path = public-dir + path
      file = full-path + 'index'
      template = tmpl "protocols/show"

      mkdirp full-path

      options = 
        pretty: true
        protocol: data
        table: in-this-protocol(protocol.name, database)
        routes: routes 'protocols', 2
        t: translation

      write-html template, options, file
      write-json data, file

  # WRITE projects/index
  do ->
    data = database
    path = 'projects/index'
    file = public-dir + path
    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes 'projects', 1
      t: translation

    write-html template, options, file
    write-json data, file

  # WRITE projects/show
  do ->
    for project in database
      data = project
      path = "projects/#{project.slug}/"
      full-path = public-dir + path
      file = full-path + 'index'
      template = tmpl "projects/show"

      mkdirp full-path

      options = 
        pretty: true
        project: project
        routes: routes 'projects', 2
        t: translation

      write-html template, options, file
      write-json data, full-path
