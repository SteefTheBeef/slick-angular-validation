# Gulangco Plate
Yupp, another AngularJS project boilerplate and build tool!

Gulangco Plate comes prepackaged with [jQuery](http://jquery.com), [Twitter Bootstrap](http://getbootstrap.com), [AngularStrap](http://mgcrea.github.io/angular-strap), [Angular UI Router](https://github.com/angular-ui/ui-router) and some good-to-have native angular modules: ngAnimate, ngResource, ngSanitize and ngMock for testing purposes. 

[LESS](http://lesscss.org) and [CoffeeScript](http://coffeescript.org) is supported out of the box. In fact, this whole project is written in CoffeeScript!

Angular unit testing, powered by [Karma Test Runner](http://karma-runner.github.io) and [Jasmine](http://jasmine.github.io) syntax is available by simply running `gulp test`, there are a few example tests included to get you going.

## Quick Start

```
- git clone git://github.com/SteefTheBeef/gulangco-plate
- cd gulangco-plate
- npm -g install gulp karma bower
- npm install
- bower install
- gulp build
```

## Directory Structure

```
gulangco-plate/
  |- gulp/
  |  |- config/
  |  |  |- karma.conf.coffee <test config>
  |  |  |- paths.coffee <file paths config>
  |  |- tasks/ <gulp tasks divided into separate files>
  |- less 
  |  |- <all styles belong here>
  |- src/
  |  |- app/
  |  |  |- <controllers, views>
  |  |- common/
  |  |  |- <services and directives>
  |  |- config/
  |  |  |- registerModules.coffee <register angular modules and app dependecies>
  |  |- app.coffee <routes defined here and general app-logic>
  |- bower.json
  |- gulpfile.coffee <gulp tasks defined in this file>
  |- package.json
  |- index.html
```

## Gulp tasks
The most important ones are
```
- gulp build
- gulp compile
- gulp test
```
### Gulp build
this task does the following in order
```
cleans build dir
copies vendor(bower) files
compiles CoffeeScript files
compiles LESS files
copies html templates
injects js and css files into index.html
starts http server
watches and recompiles on file changes
```
