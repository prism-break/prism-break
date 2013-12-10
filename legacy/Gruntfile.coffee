module.exports = (grunt) ->

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')

    concat:
      options:
        separator: ';'
      lib:
        src: ['src/**/*.js']
        dest: 'lib/js/app.js'
      vendor:
        src: ['vendor/**/*.js']
        dest: 'lib/js/vendor.js'

    uglify: 
      options: 
        banner: 
          '/*\n@licstart  The following is the entire license notice for the JavaScript code in this page.\n\nCopyright (C) 2013 their respective owners\n\nThe JavaScript code in this page is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License (GNU GPL) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.  The code is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU GPL for more details.\n\n As additional permission under GNU GPL version 3 section 7, you may distribute non-source (e.g., minimized or compacted) forms of that code without the copy of the GNU GPL normally required by section 4, provided you include this license notice and a URL through which recipients can access the Corresponding Source.\n\n\n@licend  The above is the entire license notice for the JavaScript code in this page.\n*/\n'

      lib:
        files:
          'lib/js/app.min.js': ['<%= concat.lib.dest %>']
          'lib/js/vendor.min.js': ['<%= concat.vendor.dest %>']

    stylus:
      lib:
        files:
          'lib/css/screen.css': ['src/styl/screen.styl']

    watch:
      files: ['src/**']
      tasks: ['concat', 'uglify', 'stylus']
  )

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['concat', 'uglify', 'stylus'])
