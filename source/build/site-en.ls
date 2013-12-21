'use strict'

#function
{write-localized-site} = require '../functions/build.ls'

# data 
{projects-raw} = require '../db/en-projects.ls'
{projects-rejected-raw} = require '../db/en-projects-rejected.ls'
{platform-types} = require '../db/en-platform-types.ls'
{protocols-raw} = require '../db/en-protocols.ls'

data =
  projects-raw: projects-raw
  projects-rejected-raw: projects-rejected-raw
  platform-types: platform-types
  protocols-raw: protocols-raw

# translation
i18n = require '../i18n/index.ls'

iso = 'en'
locale = i18n[iso]

write-localized-site(iso, locale, data)
