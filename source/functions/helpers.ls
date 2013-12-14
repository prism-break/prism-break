truncator = (text, chars) ->
  if text.length > chars + 1
    truncated-text = text.slice 0, chars
    add-ellipsis = truncated-text + '&hellip;'
  else
    text

exports.marked = require 'marked'
exports.truncator = truncator

