
define(function(require, exports){

  exports.ctrl = function($scope, $http, $location){
    
    $http.get('/blog').success(function(posts){
      $scope.posts = posts;
    });


    
    $scope.edit = function(post){
      post.view_status = 'edit';

      post._title = post.title;
      post._content = post.content;
    }


    $scope.update = function(post){
      $http({
        url: '/blog/update',
        data: "id=" + post.id + "&title=" + post._title + "&content=" + post._content,
        method: 'POST',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }
      }).success(function(){
        post.title = post._title;
        post.content = post._content;

        post.view_status = null;
      }).error(function(err){
        post._error = err;
      });
    }


    $scope.reset = function(post){
      post.view_status = null;
    }
  }
  
});

