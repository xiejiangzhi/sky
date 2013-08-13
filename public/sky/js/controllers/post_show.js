
define(function(require, exports){
  // var 
  var alert = require('alert');

  exports.ctrl= function($scope, $http, $routeParams){
    $http.get('/posts/show?' + $.param({
      id: $routeParams.id
    })).success(function(data){
      $scope.post = data;
    }).error(function(data){
      alert.error(data);
    });
    

    $scope.to_html = require('preview_html').to_html;
  }
  
});
