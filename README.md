# Gulangco Plate
Yupp, another AngularJS project boilerplate and build tool!

Gulangco Plate comes prepackaged with [jQuery](http://jquery.com), [Twitter Bootstrap](http://getbootstrap.com), [AngularStrap](http://mgcrea.github.io/angular-strap), [Angular UI Router](https://github.com/angular-ui/ui-router) and some good-to-have native angular modules: ngAnimate, ngResource, ngSanitize and ngMock for testing purposes. 

[LESS](http://lesscss.org) and [CoffeeScript](http://coffeescript.org) is supported out of the box. In fact, this whole project is written in CoffeeScript!

Angular unit testing, powered by [Karma Test Runner](http://karma-runner.github.io) and [Jasmine](http://jasmine.github.io) syntax is available by simply running `gulp test`, there are a few example tests included to get you going.

## Quick Start

```sh
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
  |  |- app.coffee <routes in here>
  |- bower.json
  |- gulpfile.coffee <gulp tasks defined in this file>
  |- package.json
  |- index.html
```
