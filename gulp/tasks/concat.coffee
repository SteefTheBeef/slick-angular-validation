gulp = require 'gulp'
concat = require 'gulp-concat'
streamify = require('gulp-streamify')

module.exports = (sourceFiles, filename, dest) ->
  gulp.src(sourceFiles)
  .pipe(streamify(concat(filename)))
  .pipe(gulp.dest(dest))
