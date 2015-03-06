gulp = require 'gulp'
coffee = require 'gulp-coffee'
ngAnnotate = require 'gulp-ng-annotate'
streamify = require('gulp-streamify')

module.exports = (sourceFiles, destination) ->
  gulp.src(sourceFiles, { base: "." })
  .pipe(streamify(coffee({ bare: true })))
  .pipe(streamify(ngAnnotate()))
  .pipe(gulp.dest(destination))