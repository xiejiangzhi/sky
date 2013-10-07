
define(function(require, exports){
  var alert = require('alert');
  var waterfall_stream = require('waterfall_stream');
  var conversion = require("preview_html");
  
  require('markdown');
  var markdown = window.markdown;


  exports.ctrl = function($scope, $http){

    $scope.config = {
      new_view: false,
      page: 1
    };
    var tmp_year = {};


    get_posts();
    waterfall_stream.callback = function(cont){
      if ($scope.config.count_page <= $scope.config.page) { return ; }

      $scope.config.page += 1;
      get_posts(cont);
    };




    $scope.to_html = conversion.to_html;



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

