'use strict'

# libraries
require! jade
require! fs
require! mkdirp
{slugify-db, subcategories-in, countries-in, in-this-subcategory, in-this-country, categories-tree, nested-categories, countries-tree} = require '../functions/sort.ls'
{tmpl, routes, write-json} = require '../functions/paths.ls'

# data
{data} = require '../data/cities-en.ls'
translations = require '../translations'

# the main database
database = slugify-db data


######################################################################
# WRITE
######################################################################

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

  # WRITE countries/index
  do ->
    data = countries-tree(database)
    path = 'countries/index'
    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes 'countries', 1
      t: translation

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

  # WRITE countries/show
  do ->
    for country in countries-in(database)
      data = country
      path = "countries/#{country.slug}/"
      template = tmpl "countries/show"

      directory = public-dir + path
      mkdirp directory

      options = 
        pretty: true
        country: data
        table: in-this-country(country.name, database)
        routes: routes 'countries', 2
        t: translation

      jade.render-file template, options, (err, html) ->
        file = directory + 'index.html'
        fs.write-file file, html, (err) ->
          if err
            console.log err
          else
            console.log "#{file} saved"

      write-json data, public-dir + path + "index"

  # WRITE cities/index
  do ->
    data = database
    path = 'cities/index'
    template = tmpl path

    options = 
      pretty: true
      table: data
      routes: routes 'cities', 1
      t: translation

    jade.render-file template, options, (err, html) ->
      file = public-dir + path + '.html'
      fs.write-file file, html, (err) ->
        if err
          console.log err
        else
          console.log "#{file} saved"

    write-json data, public-dir + path

  # WRITE cities/show
  do ->
    for city in database
      data = city
      path = "cities/#{city.slug}/"
      template = tmpl "cities/show"

      directory = public-dir + path
      mkdirp directory

      options = 
        pretty: true
        city: city
        routes: routes 'cities', 2
        t: translation

      jade.render-file template, options, (err, html) ->
        file = directory + 'index.html'
        fs.write-file file, html, (err) ->
          if err
            console.log err
          else
            console.log "#{file} saved"

      write-json data, public-dir + path + "index"
