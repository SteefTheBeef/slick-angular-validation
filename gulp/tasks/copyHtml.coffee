gulp = require 'gulp'

module.exports = (sourceFiles, destination) ->
  gulp.src(sourceFiles, { base: "." })
  .pipe(gulp.dest(destination))