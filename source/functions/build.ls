{sort-by} = require 'prelude-ls'
load-data = require './load-data.ls'
{write-localized-site} = require './write.ls'
{slugify-db} = require './sort.ls'

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
    projects-rejected: sort-by (.name.to-lower-case!), projects-rejected
    protocols: slugify-db protocols

  write-localized-site(db)
