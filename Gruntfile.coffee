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
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
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
