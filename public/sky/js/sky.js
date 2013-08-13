
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
      .when('/blog/:id', {
        controller: sa.autoload('post_show', 'post_show.css'),
        templateUrl: '/template/posts/show'
      })
      .otherwise({redirectTo:'/'});
  });

  Sky.controller('AlertCtrl', alert.ctrl);
});
