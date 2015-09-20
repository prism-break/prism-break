'use strict'

{write-localized-site} = require './write.ls'
{slugify-db} = require './sort.ls'

export build-site = (iso) ->

  locale =              require "../locales/#{iso}.json"
  projects =            require "../db/#{iso}-projects.json"
  protocols =           require "../db/protocols/#{iso}-protocols.json"
  {projects-rejected} = require '../db/en-projects-rejected.ls'
  {platform-types} =    require '../db/en-platform-types.ls'

  db =
    dir: "tmp/#{iso}/"
    iso: iso
    locale: locale
    platform-types: platform-types
    projects: slugify-db projects
    projects-rejected: projects-rejected
    protocols: slugify-db protocols

  write-localized-site(db)
