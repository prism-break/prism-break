'use strict'

# libraries
require! '../functions/helpers.ls'
{map, keys, values, zip, pairs-to-obj} = require 'prelude-ls'
{select-random, slugify-db, slugify-project, subcategories-of, images-in, in-this-category, in-this-subcategory, in-these-subcategories, in-this-protocol, nested-categories, platform-types, protocol-types} = require '../functions/sort.ls'
{view-path, write-html, write-json} = require '../functions/paths.ls'
{routes} = require '../functions/routes.ls'

# data
{projects-raw} = require '../db/en-projects.ls'
projects = slugify-db projects-raw

#write-json projects, "./built/en-projects"

languages = []
languages["ar"] = require './ar.json'
languages["ca"] = require './ca.json'
languages["de"] = require './de.json'
languages["el"] = require './el.json'
languages["en"] = require './en.json'
languages["eo"] = require './eo.json'
languages["es"] = require './es.json'
languages["fa"] = require './fa.json'
languages["fi"] = require './fi.json'
languages["fr"] = require './fr.json'
languages["he"] = require './he.json'
languages["hi"] = require './hi.json'
languages["hu"] = require './hu.json'
languages["io"] = require './io.json'
languages["it"] = require './it.json'
languages["ja"] = require './ja.json'
languages["nl"] = require './nl.json'
languages["no"] = require './no.json'
languages["pl"] = require './pl.json'
languages["pt"] = require './pt.json'
languages["ru"] = require './ru.json'
languages["sr"] = require './sr.json'
languages["sr-Cyrl"] = require './sr_cr.json'
languages["sv"] = require './sv.json'
languages["tr"] = require './tr.json'
languages["zh-CN"] = require './zh_cn.json'
languages["zh-TW"] = require './zh_tw.json'

for iso639, translations of languages
  list-of-projects = projects
  for project in list-of-projects
    for key, value of translations
      if key == project.slug
        project.description = value
        delete translations[key]

  list-of-projects
  translations

  write-json list-of-projects, "./built/#{iso639}-projects"
  write-json translations, "./built/#{iso639}-reduced"
