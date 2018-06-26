assign = require 'lodash.assign'
isequal = require 'lodash.isequal'

# TODO: support overrides
# Then we can expand this list to include e.g. wikipedia_url, but not warn in situations where there isn't a translated Wikipedia article
# When we do this we should warn about the presence of non-translatable keys (e.g. the `protocols` key should always be consistent)
translatable = ['notes', 'description']

module.exports = load-data = (path, iso, find-missing = false) ->
  en-data = require path.replace('/' + iso, '/en')
  localized-data = require path

  for obj in en-data
    # Look for a localized version
    potential-localized-obj = null
    for localized-obj in localized-data
      if localized-obj.slug is obj.slug
        potential-localized-obj = assign {}, obj, localized-obj
        break

    if find-missing
      if not potential-localized-obj
        console.log 'Missing ' + iso + ' localization for ' + obj.slug
        continue
      else
        # First we check if entire objects are duplicated
        # We use localized-obj because potential-localized-obj has already been filled in by lodash.assign
        if isequal obj, localized-obj
          console.log iso + ' localization of ' + obj.slug + ' duplicates the English version'
        # Then we check for per-key problems
        else
          # For each (non-empty) localizable key in the English version...
          for key of obj when translatable.includes key and obj[key] is not ''
              # ...check if it hasn't been localized at all
              if not localized-obj[key]
                console.log 'Missing ' + iso + ' localization for key `' + key + '` in project ' + obj.slug
              # ...check if the localized version is a duplicate
              else if isequal obj[key], localized-obj[key]
                console.log iso + ' localization of key `' + key + '` in project ' + obj.slug + ' duplicates the English version'

        continue

    potential-localized-obj or obj
