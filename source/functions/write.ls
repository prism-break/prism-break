require! mkdirp
require! './helpers.ls'
{sort-by, unique} = require \prelude-ls
{select-random, slugify-db, slugify-project, in-this-category, in-this-subcategory, nested-subcategories, in-this-protocol, nested-categories-web, platform-types, protocol-types} = require './sort.ls'

view-path = (view-name) ->
  'source/views/' + view-name + '.pug'

routes = (subdirectory, depth) ->
  if depth?
    if depth == 0
      prefix = './'
    else if depth == 1
      prefix = '../'
    else if depth == 2
      prefix = '../../'
    else
      console.log "depth only goes to 2"
  else
    prefix = './'

  bare-paths =
    css: '../assets/css/screen.css'
    about: 'about/'
    all: 'all/'
    categories: 'categories/'
    icons: '../assets/icons/'
    logos: '../assets/logos/'
    logos-rejected: '../assets/logos/'
    projects: 'projects/'
    protocols: 'protocols/'
    public: '../'
    root: ''
    subcategories: 'subcategories/'

  final-paths = {}
  for key, value of bare-paths
    if subdirectory == value
      if depth == 2
        final-paths[key] = '../'
      else
        final-paths[key] = '.'
    else
      final-paths[key] = prefix + value
  final-paths

fs = require 'fs'
pug = require 'pug'

write-html = (view, options, file) ->
  options.cache = true;
  options.compileDebug = false;
  fs.writeFileSync(file + ".html", (pug.renderFile view, options))

############################################################################
# WRITE FUNCTIONS
# These functions write all of the HTML pages for the entire site.

export write-localized-site = (db) ->
  mkdirp db.dir

  write-site-index db
  write-all-index db
  write-categories-index db
  write-categories-show db
  write-subcategories-show db
  write-protocols-index db
  write-protocols-show db
  write-projects-index db
  write-projects-show db
  write-about-index db
  write-about-media db

write-site-index = (db) ->
  data = db.platform-types db.projects

  path = 'index'
  view = view-path path
  options = 
    iso: db.iso
    body-class: "#{db.iso} root index"
    h: helpers
    platform-types: data
    path: ''
    routes: routes!
    t: db.locale
  file = db.dir + path

  write-html view, options, file
  
write-all-index = (db) ->
  data = nested-subcategories db.projects, db.projects-rejected

  path = 'all/index'
  view = view-path path
  options = 
    iso: db.iso
    body-class: "#{db.iso} all index"
    h: helpers
    subcategories: data
    path: 'all'
    routes: routes 'all', 1
    t: db.locale
  file = db.dir + path

  write = -> write-html view, options, file

  mkdirp db.dir + 'all', (err) ->
    if err => console.error err
    else write! 

write-categories-index = (db) ->
  data = db.platform-types db.projects

  path = 'categories/index'
  view = view-path path
  options = 
    iso: db.iso
    body-class: "#{db.iso} categories index"
    h: helpers
    platform-types: data
    path: 'categories'
    routes: routes 'categories', 1
    t: db.locale
  file = db.dir + path

  write = ->
    write-html view, options, file

  mkdirp db.dir + 'categories', (err) ->
    if err => console.error err
    else write!

write-categories-show = (db) ->
  create = (category) ->
    data = category

    for subcategory in data.subcategories
      projects-rejected = in-this-subcategory(
        subcategory.name,
        in-this-category(category.name, db.projects-rejected)
      )
      projects-rejected-web = in-this-subcategory(
        subcategory.name,
        in-this-category('Web Services', db.projects-rejected)
      )
      projects-rejected-all = sort-by(
        (.name.to-lower-case!),
        unique(projects-rejected.concat(projects-rejected-web))
      )
      subcategory.projects-rejected = projects-rejected-all

    path = "categories/#{category.slug}/"
    view = view-path 'categories/show'
    options = 
      iso: db.iso
      body-class: "#{db.iso} categories show"
      h: helpers
      category: category
      platform-types: db.platform-types db.projects
      path: path
      routes: routes 'categories', 2
      t: db.locale
    full-path = db.dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories-web(db.projects)
    create category

write-subcategories-show = (db) ->
  create = (subcategory) ->

    projects-rejected = in-this-subcategory(
      subcategory.name,
      in-this-category(category.name, db.projects-rejected)
    )
    projects-rejected-web = in-this-subcategory(
      subcategory.name,
      in-this-category('Web Services', db.projects-rejected)
    )
    projects-rejected-all = sort-by(
      (.name.to-lower-case!),
      unique(projects-rejected.concat(projects-rejected-web))
    )
    data =
      category: category
      subcategory: subcategory
      projects: subcategory.projects
      projects-rejected: projects-rejected-all

    path = "subcategories/#{category.slug}-#{subcategory.slug}/"
    view = view-path 'subcategories/show'
    options = 
      iso: db.iso
      body-class: "#{db.iso} subcategories show"
      h: helpers
      data: data
      path: path
      routes: routes 'subcategories', 2
      t: db.locale
    full-path = db.dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for category in nested-categories-web(db.projects)
    for subcategory in category.subcategories
      create subcategory

write-protocols-index = (db) ->
  data = protocol-types db.protocols

  path = 'protocols/index'
  view = view-path path
  options = 
    iso: db.iso
    body-class: "#{db.iso} protocols index"
    h: helpers
    protocol-types: data
    path: 'protocols'
    routes: routes 'protocols', 1
    t: db.locale
  file = db.dir + path

  write = ->
    write-html view, options, file

  mkdirp db.dir + 'protocols', (err) ->
    if err
      console.error err
    else
      write!

write-protocols-show = (db) ->
  create = (protocol) ->
    protocol.projects = in-this-protocol(protocol.name, db.projects)
    data = protocol

    path = "protocols/#{protocol.slug}/"
    view = view-path 'protocols/show'
    options = 
      iso: db.iso
      body-class: "#{db.iso} protocols show"
      h: helpers
      protocol: data
      protocol-types: protocol-types db.protocols
      path: path
      routes: routes 'protocols', 2
      t: db.locale
    full-path = db.dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file

    mkdirp full-path, (err) ->
      if err
        console.error err
      else
        write!

  for protocol in db.protocols
    create protocol

write-projects-index = (db) ->
  data = db.projects

  path = 'projects/index'
  view = view-path path
  options = 
    iso: db.iso
    body-class: "#{db.iso} projects index"
    h: helpers
    projects: data
    path: 'projects'
    routes: routes 'projects', 1
    t: db.locale
  file = db.dir + path

  write = ->
    write-html view, options, file

  mkdirp db.dir + 'projects', (err) ->
    if err
      console.error err
    else
      write!

write-projects-show = (db) ->
  create = (project) ->
    data = slugify-project project

    path = "projects/#{project.slug}/"
    view = view-path 'projects/show'
    options = 
      iso: db.iso
      body-class: "#{db.iso} projects show"
      h: helpers
      project: data
      routes: routes 'projects', 2
      t: db.locale
      path: path
    full-path = db.dir + path
    file = full-path + 'index'

    write = ->
      write-html view, options, file

    mkdirp full-path, (err) ->
      if err => console.error err
      else write!

  for project in db.projects
    create project

write-about-index = (db) ->
  create = ->
    path = 'about/index'
    view = view-path path
    options =
      iso: db.iso
      body-class: "#{db.iso} about index"
      h: helpers
      path: 'about'
      routes: routes 'about', 1
      t: db.locale
    file = db.dir + path

    write = -> write-html view, options, file

    mkdirp db.dir + 'about', (err) ->
      if err => console.error err
      else write!

  create!

write-about-media = (db) ->
  create = ->
    path = 'about/media/'
    view = view-path 'about/media'
    options =
      iso: db.iso
      body-class: "#{db.iso} about media"
      h: helpers
      path: path
      routes: routes 'about', 2
      t: db.locale
    full-path = db.dir + path
    file = full-path + 'index'

    write = -> write-html view, options, file

    mkdirp full-path, (err) ->
      if err => console.error err
      else write!

  create!
