'use strict'

chunk = (array, size) ->
  j = array.length
  chunks = []

  for i from size til j by size
    chunks.push array.slice(i - size, i)

  chunks

exports.chunk = chunk
