gulp = require 'gulp'
del = require 'del'

module.exports = (path, done) ->
  del path, () -> done()

