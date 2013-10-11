
define(function(require, exports){

  require('md5');
  var alert = require('alert');

  exports.ctrl = function($scope, $http, $routeParams){
    $scope.user = window.current_user;
    $scope.new_user = {};
    $scope.md5 = md5;

    $scope.show_login_box = function(){
      $scope.login_box = true;
    }

    $scope.cancel_login = function(){
      $scope.login_box = false;
      $scope.new_user = {};
    }



    $scope.login = function(){
      $http.post('/users/login', $scope.new_user)
      .success(function(data){
        $.extend(window.current_user, data);
        $scope.cancel_login();
      }).error(function(data){
        alert.error(data);
      });
    }
  }

});
