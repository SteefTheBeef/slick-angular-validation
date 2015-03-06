gulp = require 'gulp'
source = require 'vinyl-source-stream'
browserify = require 'browserify'

module.exports = (sourceFiles, bundleFilename, destination) ->
  bundleStream = browserify({
    bare: true
    entries: sourceFiles,
    extensions: ['.coffee']
  }).bundle()

  bundleStream
  .pipe(source(bundleFilename))
  .pipe(gulp.dest(destination))

