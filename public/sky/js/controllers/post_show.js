
define(function(require, exports){
  var alert = require('alert');

  exports.ctrl= function($scope, $http, $routeParams){
    $http.get('/posts/show?' + $.param({
      id: $routeParams.id
    })).success(function(data){
      $scope.post = data;
      init_answer();
    }).error(function(data){
      alert.error(data);
      $scope.answers = [];
    });
    

    $scope.answer_view = 'edit';
    $scope.to_html = require('preview_html').to_html;
    $scope.answer = {
      language: 'markdown'
    };



    $scope.create_answer = function(){
      var params = $.extend({target_id: $routeParams.id}, $scope.answer)

      $http.post('/posts/answer', params)
      .success(function(data){
        $scope.answers.unshift(data['answer']);
        $scope.answer.content = '';
      }).error(function(data){
        alert.error(data);
      });
    }



    function init_answer(){
      $http.get('/posts/answer_list?' + $.param({
        target_id: $routeParams.id
      })).success(function(data){
        $scope.answers = data['items'];
      }).error(function(data){
        alert.error(data);
        $scope.answers = [];
      });
    }
  }
  
});
