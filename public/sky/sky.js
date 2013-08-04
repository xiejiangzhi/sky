
// routes

(function(global){
  var Sky = angular.module('sky', []);

  Sky.config(function($routeProvider){
    $routeProvider
      .when('/', {
        controller: remote_controller('home'),
        templateUrl: '/template/index'
      })
      .when('/blog', {
        controller: remote_controller('blog/posts/index'),
        templateUrl: '/template/blog/posts/index'
      })
      .when('/blog/posts/edit/:id', {
        controller: remote_controller('blog/posts/edit'),
        templateUrl: '/template/blog/posts/edit'
      })
      .otherwise({redirectTo:'/'});
  });




  function remote_controller(module) {
    var injector = ['$scope'];
    var bak = injector.slice(0, injector.length);

    bak.push('$injector');

    bak.push(function() {
      var $injector = arguments[arguments.length - 1];
      var inject_opts = {};
      var that = this;

      for (var i = 0; i < injector.length; i++) {
        inject_opts[injector[i]] = arguments[i];
      }


      seajs.use(module, function(m) {
        $injector.invoke(m.ctrl, that, inject_opts);
      });
    });

    return bak;
  }
}(window));
