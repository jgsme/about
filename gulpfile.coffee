gulp = require 'gulp'
cson = require 'gulp-cson'
styl = require 'gulp-stylus'
jade = require 'gulp-jade-template'
data = require 'gulp-data'
cnct = require 'gulp-connect'

paths =
  static: ['src/CNAME', 'src/robots.txt']
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

gulp.task 'jade', ->
  gulp.src paths.data
    .pipe cson()
    .pipe jade 'src/index.jade'
    .pipe data (file)->
      file.path = file.path.replace /json$/, 'html'
      file
    .pipe gulp.dest paths.dest

gulp.task 'default', ['copy', 'styl', 'jade']
gulp.task 'serve', ['default'], ->
  cnct.server
    root: paths.dest
    port: 8082
gulp.task 'deploy', ->
  gulp.src './build/**/*'
    .pipe deploy
      cacheDir: 'tmp'
