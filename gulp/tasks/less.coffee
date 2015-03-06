gulp = require 'gulp'
streamify = require('gulp-streamify')
minifyCSS =
less = require 'gulp-less'

module.exports = (sourceFiles, destination, minify = false) ->
  if minify
    stream = gulp.src(sourceFiles)
    .pipe(streamify(less()))
    .pipe(minifyCSS())
    .pipe(gulp.dest(destination))
  else
    stream = gulp.src(sourceFiles)
    .pipe(streamify(less()))
    .pipe(gulp.dest(destination))
  stream


