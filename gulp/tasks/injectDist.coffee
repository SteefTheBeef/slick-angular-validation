gulp = require 'gulp'
series = require 'stream-series'
es = require 'event-stream'
inject = require 'gulp-inject'
streamify = require('gulp-streamify')

module.exports = (htmlFile, sourceFilesJS, sourceFilesCSS, destination) ->
  gulp.src(htmlFile)
  .pipe(inject(gulp.src(sourceFilesJS, {read: false}), {ignorePath: 'dist', addRootSlash: false }))
  .pipe(inject(gulp.src(sourceFilesCSS, { read: false } ), {ignorePath: 'dist', addRootSlash: false}))
  .pipe(gulp.dest(destination))