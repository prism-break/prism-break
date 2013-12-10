'use strict'

# libraries
require! jade
require! fs
require! mkdirp
{slugify-db, subcategories-in, protocols-in, in-this-subcategory, in-this-protocol, categories-tree, nested-categories, protocols-tree} = require '../functions/sort.ls'
{tmpl, routes, write-json} = require '../functions/paths.ls'

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

    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes!
      t: translation

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

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

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

  # WRITE categories/show
  do ->
    for category in nested-categories(database)
      data = subcategories-in(category.name, database)
      path = "categories/#{category.slug}/"
      template = tmpl "categories/show"

      directory = public-dir + path
      mkdirp directory

      options = 
        pretty: true
        category: category
        table: data
        routes: routes 'categories', 2
        t: translation

      jade.render-file template, options, (err, html) ->
        file = directory + 'index.html'
        fs.write-file file, html, (err) ->
          if err
            console.log err
          else
            console.log "#{file} saved"

      write-json data, public-dir + path + "index"

  # WRITE subcategories/show
  do ->
    for category in nested-categories(database)
      for subcategory in category.subcategories
        data = in-this-subcategory(subcategory.name, database)
        path = "subcategories/#{category.slug}-#{subcategory.slug}/"
        template = tmpl "subcategories/show"

        directory = public-dir + path
        mkdirp directory

        options = 
          pretty: true
          category: category
          category-file: "../../categories/#{category.slug}"
          subcategory: subcategory
          table: data
          routes: routes 'subcategories', 2
          t: translation

        jade.render-file template, options, (err, html) ->
          file = directory + 'index.html'
          fs.write-file file, html, (err) ->
            if err
              console.log err
            else
              console.log "#{file} saved"

        write-json data, public-dir + path + "index"

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

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

  # WRITE protocols/show
  do ->
    for protocol in protocols-in(database)
      data = protocol
      path = "protocols/#{protocol.slug}/"
      template = tmpl "protocols/show"

      directory = public-dir + path
      mkdirp directory

      options = 
        pretty: true
        protocol: data
        table: in-this-protocol(protocol.name, database)
        routes: routes 'protocols', 2
        t: translation

      jade.render-file template, options, (err, html) ->
        file = directory + 'index.html'
        fs.write-file file, html, (err) ->
          if err
            console.log err
          else
            console.log "#{file} saved"

      write-json data, public-dir + path + "index"

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

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

  # WRITE projects/show
  do ->
    for project in database
      data = project
      path = "projects/#{project.slug}/"
      template = tmpl "projects/show"

      directory = public-dir + path
      mkdirp directory

      options = 
        pretty: true
        project: project
        routes: routes 'projects', 2
        t: translation

      jade.render-file template, options, (err, html) ->
        file = directory + 'index.html'
        fs.write-file file, html, (err) ->
          if err
            console.log err
          else
            console.log "#{file} saved"

      write-json data, public-dir + path + "index"
