
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
      var origin = $.extend({}, post);

      post.view_status = 'edit';
      post._origin = origin;
    }


    $scope.new = function(){
      $scope.config.new_view ^= true;

      $scope.post = {
        title: '',
        content: '',
        language: 'markdown',
        view_status: 'edit'
      }
    }


    $scope.create = function(post){
      $http.post('/posts/create', {
          title: post.title,
          content: post.content,
          language: post.language
      }).success(function(data){
        
        $scope.config.new_view = false;

        $scope.posts.items.unshift(data.post);
      }).error(function(err){
        post.error = err;
      });
    }


    $scope.update = function(post){
      $http.post('/posts/update', {
          id: post._id,
          title: post.title,
          content: post.content,
          language: post.language
      }).success(function(){
        post.view_status = null;
      }).error(function(err){
        post._error = err;
      });
    }


    $scope.previewHTML = function(post, limit){
      html = '';

      switch (post.language) {
      case 'markdown':
        html = markdown.toHTML(post.content || "");
        break;
      case 'html':
        html = post.content;
        break;
      case 'text':
        html = $("<div />").text(post.content).html();
        break;
      default:
        html = post.content;
      }

      if (limit){
        return html.slice(0, limit);
      } else {
        return html;
      }
    }


    $scope.reset = function(post){
      post.view_status = null;

      if (post,_origin) {
        $.extend(post, post._origin);
        delete post._origin;
      }
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

