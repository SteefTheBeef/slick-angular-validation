gulp = require 'gulp'
series = require 'stream-series'
es = require 'event-stream'
inject = require 'gulp-inject'
streamify = require('gulp-streamify')

module.exports = (htmlFile, sourceFilesJS, sourceFilesVendorJS, sourceFilesCSS, destination) ->
  vendorStream = gulp.src(sourceFilesVendorJS, {read: false})
  appStream = gulp.src(sourceFilesJS, {read: false})
  gulp.src(htmlFile)
  .pipe(inject(series(vendorStream, appStream), {ignorePath: 'build', addRootSlash: false }))
  .pipe(inject(gulp.src(sourceFilesCSS, { read: false } ), {ignorePath: 'build', addRootSlash: false}))
  .pipe(gulp.dest(destination))
  .on 'error', (err) ->
    console.log err