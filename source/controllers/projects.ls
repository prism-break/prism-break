'use strict'

# libraries
require! mkdirp
require! '../functions/helpers.ls'
{select-random, slugify-db, slugify-project, subcategories-of, images-in, in-this-category, in-this-subcategory, in-these-subcategories, in-this-protocol, nested-categories, platform-types, protocol-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'
{routes} = require '../functions/routes.ls'

# data
{projects-raw} = require '../db/en-projects.ls'
i18n = require '../i18n/index.ls'

# slugging the data for urls
projects-db = slugify-db projects-raw


############################################################################
# WRITE FUNCTIONS
# These functions write all of the HTML pages for the entire site.


write-projects-show = (translation) ->
  create = (project) ->
    data = slugify-project project
    data.subcategories = subcategories-of project
    #data.projects-related = in-these-subcategories(subcategories-of(project), projects-db)
    data.related = in-this-subcategory('Video & Voice', projects-db)

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

############################################################################
# WRITE SITE
# This function will write all of the HTML pages per site language.


for language, translation of i18n

  t = translation
  public-dir = "public/#{language}/"
  mkdirp public-dir

  write-projects-show translation
