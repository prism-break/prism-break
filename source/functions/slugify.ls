# source: https://stackoverflow.com/a/5782563
export slugify = (string) ->
  string = string.replace(/^\s+|\s+$/g, '')
  string = string.to-lower-case!

  accents = "ãàáäâẽèéëêìíïîõòóöôùúüûñç·/_,:;"
  accent-safe = "aaaaaeeeeeiiiiooooouuuunc------"
  for i from 0 to accents.length by 1
    string = string.replace(new RegExp(accents.char-at(i), 'g'), accent-safe.char-at(i))

  # remove invalid chars
  string = string.replace(/[^a-z0-9 -]/g, '') 

  # collapse whitespace and replace by -
  string = string.replace(/\s+/g, '-')    

  # collapse dashes
  string = string.replace(/-+/g, '-'); 
