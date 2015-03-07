gulp = require 'gulp'
cson = require 'gulp-cson'
jade = require 'gulp-jade-template'
data = require 'gulp-data'

module.exports = (filename)->
  {paths} = require '../../gulpfile'
  gulp.src paths.data
    .pipe cson()
    .pipe gulp.dest paths.dest
    .pipe jade filename
    .pipe data (file)->
      path = file.path.split '/'
      name = filename.split '/'
      path[path.length-1] = name[name.length-1].replace /jade$/, 'html'
      file.path = path.join '/'
      file
    .pipe gulp.dest paths.dest
