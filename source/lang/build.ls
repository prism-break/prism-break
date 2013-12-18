'use strict'

# libraries
require! '../functions/helpers.ls'
{map, keys, values, zip, pairs-to-obj} = require 'prelude-ls'
{select-random, slugify-db, slugify-project, subcategories-of, images-in, in-this-category, in-this-subcategory, in-these-subcategories, in-this-protocol, nested-categories, platform-types, protocol-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'
{routes} = require '../functions/routes.ls'

# data
{projects} = require './_projects.ls'
projects = slugify-db projects
lang-json = require './ar.json'


/*
obj-zip = (json) ->
  zip (keys json), (values json)

language = pairs-to-obj obj-zip(lang-json)
*/

#console.log language.length

real-projects = []
for project in projects
  for key, value of lang-json
    slug = key.split('-')[1]
    if slug == project.slug
      project.description = value
      console.log "#{slug} EQUALS #{project.slug}"
      console.log project
      real-projects.push project
real-projects

write-json real-projects, 'ar-projects'
