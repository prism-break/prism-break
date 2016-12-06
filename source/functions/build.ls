'use strict'

assign = require 'lodash.assign'
{write-localized-site} = require './write.ls'
{slugify-db} = require './sort.ls'

load-data = (path, iso) ->
  en-data = require path.replace('/' + iso, '/en')
  localized-data = require path

  data = []

  for obj in en-data
    # Look for a localized version
    potential-localized-obj = null
    for localized-obj in localized-data
      if localized-obj.name is obj.name
        potential-localized-obj = assign {}, obj, localized-obj
        break

    potential-localized-obj or obj

export build-site = (iso) ->

  locale =              require "../locales/#{iso}.json"
  projects =            load-data "../db/#{iso}-projects.json", iso
  protocols =           load-data "../db/protocols/#{iso}-protocols.json", iso
  {projects-rejected} = require '../db/en-projects-rejected.ls'
  {platform-types} =    require '../db/en-platform-types.ls'

  db =
    dir: "public/#{iso}/"
    iso: iso
    locale: locale
    platform-types: platform-types
    projects: slugify-db projects
    projects-rejected: projects-rejected
    protocols: slugify-db protocols

  write-localized-site(db)
