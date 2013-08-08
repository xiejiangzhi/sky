
define(function(require, exports){
  var alert = require('alert');
  var waterfall_stream = require('waterfall_stream');
  require('markdown');
  var markdown = window.markdown;

  exports.ctrl = function($scope, $http, $location, $anchorScroll){

    $scope.config = {
      new_view: false,
      page: 1,
      perpage: 15
    };
    var tmp_year = {};


    get_posts();
    waterfall_stream.callback = function(cont){
      if ($scope.config.count_page <= $scope.config.page) { return ; }

      $scope.config.page += 1;
      get_posts(cont);
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

        $scope.posts.items.unshift(data.post);
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


    $scope.previewHTML = function(md_str){
      return markdown.toHTML(md_str || "");
    }


    $scope.reset = function(post){
      post.view_status = null;
    }



    $scope.show_year = function(post){
      var date = new Date(post.created_at);
      var id = date.getFullYear() + '-' + date.getMonth();

      if (tmp_year[id]) {
        return (tmp_year[id] == post._id ? true : false);        
      } else {
        tmp_year[id] = post._id;
        return true;
      }
    }

    ////////////////////////////////////////////////////
    function get_posts(callback){
      $http.get('/posts?' + jQuery.param({
        page: $scope.config.page,
        perpage: $scope.config.perpage
      })).success(function(data){
        $scope.config.count_page = data['count_page']
        $scope.posts = ($scope.posts || []).concat(data['items']);

        if (typeof callback == 'function') { callback(); }
      }).error(function(data){
        alert.error('posts request error!', data);
      });

    }
  }
});

