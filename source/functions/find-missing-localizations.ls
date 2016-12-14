'use strict'

load-data = require './load-data.ls'

iso = process.argv[2]

load-data "../db/#{iso}-projects.json", iso, true
load-data "../db/protocols/#{iso}-protocols.json", iso, true

