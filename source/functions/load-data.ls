'use strict'

assign = require 'lodash.assign'

module.exports = load-data = (path, iso) ->
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
