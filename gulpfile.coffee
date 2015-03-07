gulp = require 'gulp'
styl = require 'gulp-stylus'
cnct = require 'gulp-connect'
deploy = require 'gulp-gh-pages'
page = require './gulp/helper/page'

exports.paths = paths =
  static: ['src/CNAME', 'src/robots.txt', 'src/favicons/*']
  data: 'src/index.cson'
  styl: 'src/*.styl'
  dest: 'build'

gulp.task 'copy', ->
  gulp.src paths.static
    .pipe gulp.dest paths.dest

gulp.task 'styl', ->
  gulp.src paths.styl
    .pipe styl()
    .pipe gulp.dest paths.dest

gulp.task 'index', -> page 'src/index.jade'
gulp.task 'more', -> page 'src/more.jade'

gulp.task 'default', ['copy', 'styl', 'index', 'more']

gulp.task 'watch', ['default'], ->
  gulp.watch 'src/*', ['default']
  cnct.server
    root: paths.dest
    port: process.env.PORT || 3000

gulp.task 'deploy', ->
  gulp.src './build/**/*'
    .pipe deploy
      cacheDir: 'tmp'
