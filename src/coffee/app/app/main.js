define(["require", 'underscore', 'backbone'], function () {
var module = { exports: {} };

var Backbone, _;

_ = require('underscore');

Backbone = require('backbone');

module.exports.init = function() {
  return console.log("Hello, World!");
};


return module.exports;
});