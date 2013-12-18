routes = (subdirectory, depth)->
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
    categories: 'categories/'
    icons: '../assets/ico/'
    images: '../assets/img/'
    logos: '../assets/img/logos/medium/'
    logos-rejected: '../assets/img/logos-rejected/small/'
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

exports.routes = routes
