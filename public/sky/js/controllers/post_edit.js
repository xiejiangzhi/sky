
define(function(require, exports){ 
  var alert = require('alert');

  exports.ctrl= function($scope, $http, $routeParams, $location){

    var default_post = {
      language: 'markdown'
    };


    $scope.view_status = 'edit';
    $scope.to_html = require('preview_html').to_html;
    init_post($routeParams.id);


    $scope.submit = function(){
      $http.post('/posts/' + $scope.operact, $scope.post)
      .success(function(data){
        if ($scope.operact == 'create') {
          var post_id = data['post']['_id'];
        } else {
          var post_id = $scope.post._id;
        }

        $location.url('/posts/' + post_id);
      }).error(function(err){
        alert.error(err);
      });
    }



    function init_post(id) {
      if (id == 'new') {
        $scope.post = $.extend({}, default_post);
        $scope.operact = 'create';
        $scope.$apply();
      } else {
        $scope.operact = 'update';

        $http.get('/posts/show?' + jQuery.param({id: id}))
        .success(function(post){
          $scope.post = post;
          $scope.post.id = post._id;
        }).error(function(data){
          alert.error('post request error!', data);
          $scope.post = $.extend({}, default_post);
        });
      }
    }
  }
  
});
