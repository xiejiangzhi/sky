
// routes

define(function(require){
  require('angular');

  require('jquery');
  require('components.alert');

  var sa = require('sea_angular');
  var alert = require('alert');


  var Sky = angular.module('sky', []);


  Sky.config(function($routeProvider){
    $routeProvider
      .when('/', {
        controller: sa.autoload('home', 'home.css'),
        templateUrl: '/template/index'
      })
      .when('/blog', {
        controller: sa.autoload('posts', 'posts.css'),
        templateUrl: '/template/posts/index'
      })
      .otherwise({redirectTo:'/'});
  });

  Sky.controller('AlertCtrl', alert.ctrl);
});
