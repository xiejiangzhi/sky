
define(function(require, exports){
  var alert = require('alert');

  exports.ctrl = function($scope, $http, $location){

    $http.get('/posts').success(function(posts){
      $scope.posts = posts;
    }).error(function(data){
      alert.error('posts request error!', data);
    });


    $scope.config = {
      new_view: false
    };

    $scope.templates = {
      form: '/template/posts/form'
    };

    
    $scope.edit = function(post){
      post.view_status = 'edit';

      post._title = post.title;
      post._content = post.content;
    }


    $scope.new = function(){
      $scope.config.new_view ^= true;

      $scope.post = {
        title: '',
        content: ''
      }
    }


    $scope.create = function(post){
      $http.post('/posts/create', {
          title: post._title,
          content: post._content
      }).success(function(data){
        
        $scope.config.new_view = false;

        $scope.posts.items.push(data.post);
      }).error(function(err){
        post._error = err;
      });
    }


    $scope.update = function(post){
      $http.post('/posts/update', {
          id: post._id,
          title: post._title,
          content: post._content
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

