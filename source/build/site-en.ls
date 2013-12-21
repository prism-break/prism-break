'use strict'

# functions
{write-localized-site} = require '../functions/build.ls'
{slugify-db} = require '../functions/sort.ls'

# data 
i18n = require '../i18n/index.ls'
{projects} = require '../db/en-projects.ls'
{projects-rejected} = require '../db/en-projects-rejected.ls'
{platform-types} = require '../db/en-platform-types.ls'
{protocols} = require '../db/en-protocols.ls'

iso = 'en'

db =
  iso: iso
  dir: "public/#{iso}/"
  locale: i18n[iso]
  projects-db: slugify-db projects
  projects-rejected: projects-rejected
  protocols-db: slugify-db protocols
  platform-types: platform-types

write-localized-site(db)
