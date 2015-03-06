gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
ngAnnotate = require 'gulp-ng-annotate'
streamify = require('gulp-streamify')

module.exports = (sourceFiles, filename, dest) ->
  gulp.src(sourceFiles)
  .pipe(streamify(concat(filename)))
  .pipe(streamify(uglify()))
  .pipe(gulp.dest(dest))