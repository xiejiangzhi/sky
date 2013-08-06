
define(function(require, exports){
  var alert = require('alert');

  exports.ctrl = function($scope, $http, $location, $anchorScroll){

    $scope.config = {
      new_view: false,
      page: 1,
      perpage: 10
    };

    get_posts();
    
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


    $scope.nextpage = function() {
      if ($scope.config.page < $scope.posts.count_pages) {
        $scope.config.page += 1;
        get_posts();
      }
    }

    $scope.prepage = function() {
      if ($scope.config.page > 1) {
        $scope.config.page -= 1;
        get_posts();
      }
    }




    ////////////////////////////////////////////////////
    function get_posts(){
      $http.get('/posts?' + jQuery.param({
        page: $scope.config.page,
        perpage: $scope.config.perpage
      })).success(function(posts){
        $scope.posts = posts;
      }).error(function(data){
        alert.error('posts request error!', data);
      });

    }
  }
  
});

