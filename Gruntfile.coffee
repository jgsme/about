module.exports = (grunt) ->
  grunt.initConfig
    cson:
      compile:
        src: ['index.cson']
        dest: 'build/index.json'

    jade:
      compile:
        files:
          'build/index.html': ['index.jade']
        options:
          data: -> require './build/index.json'

    connect:
      server:
        options:
          port: 5000
          base: 'build/'
          livereload: true

    watch:
      pages:
        files: ['index.jade']
        tasks: ['jade']
      styles:
        files: ['index.styl']
        tasks: ['stylus']
      cson:
        files: ['index.cson']
        tasks: ['cson', 'copy']
      build:
        files: ['build/**']
        options:
          livereload: true

    open:
      build:
        path: 'http://localhost:5000'

    stylus:
      style:
        files:
          'build/index.css': ['index.styl']

    copy:
      build:
        src: ['index.cson', 'favicon.ico', 'robots.txt', 'CNAME']
        dest: 'build/'

    clean:
      debuild: ['build/', '.grunt/']

    'gh-pages':
      options:
        base: 'build/'
      src: ['**']

  grunt.loadNpmTasks 'grunt-cson'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-gh-pages'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['cson', 'jade', 'stylus', 'copy', 'connect', 'open', 'watch']
  grunt.registerTask 'deploy',  ['clean', 'cson', 'jade', 'stylus', 'copy', 'gh-pages']
