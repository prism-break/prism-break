export truncate = (text, chars) ->
  if text.length > chars + 1
    truncated-text = text.slice 0, chars
    add-ellipsis = truncated-text + '…'
  else
    text

exports.marked = require \marked
exports.moment = require \moment
