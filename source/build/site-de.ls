'use strict'

{write-localized-site} = require '../functions/build.ls'
{slugify-db} = require '../functions/sort.ls'

iso = 'de'
{locale} =            require "../locales/#{iso}.ls"
projects =          require "../db/#{iso}-projects.json"
{projects-rejected} = require '../db/en-projects-rejected.ls'
{platform-types} =    require '../db/en-platform-types.ls'
{protocols} =         require '../db/en-protocols.ls'

db =
  iso: iso
  dir: "public/#{iso}/"
  locale: locale
  platform-types: platform-types
  projects: slugify-db projects
  projects-rejected: projects-rejected
  protocols: slugify-db protocols

write-localized-site(db)
