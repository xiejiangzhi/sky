
// routes

define(function(require){
  require('angular');

  require('jquery');
  require('components.alert');

  var sa = require('sea_angular');
  var alert = require('alert');
  var user = require('user');


  var Sky = angular.module('sky', []);


  Sky.config(function($routeProvider){
    $routeProvider
      .when('/', {
        controller: sa.autoload('home', 'home.css'),
        templateUrl: '/template/index'
      })
      .when('/posts', {
        controller: sa.autoload('posts', 'posts.css'),
        templateUrl: '/template/posts/index'
      })
      .when('/posts/edit/:id', {
        controller: sa.autoload('post_edit', 'post_edit.css'),
        templateUrl: '/template/posts/edit'
      })
      .when('/posts/:id', {
        controller: sa.autoload('post_show', 'post_show.css'),
        templateUrl: '/template/posts/show'
      })
      .otherwise({redirectTo:'/'});
  });

  Sky.controller('AlertCtrl', alert.ctrl);
  Sky.controller('UserCtrl', user.ctrl);
});
