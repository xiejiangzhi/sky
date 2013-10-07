
define(function(require, exports){
  var alert = require('alert');
  require('md5');


  exports.ctrl= function($scope, $http, $routeParams){
    $scope.to_html = require('preview_html').to_html;
    $scope.md5 = md5;

    $http.get('/posts/show?' + $.param({
      id: $routeParams.id
    })).success(function(data){
      $scope.post = data;
      load_answers();
    }).error(function(data){
      alert.error(data);
      $scope.answers = [];
    });
    
    $scope.pager = {
      current_page: 1,
      count_pages: 1
    };
    $scope.answer_view = 'edit';
    $scope.answer = {
      language: 'markdown'
    };
    $scope.current_user = window.current_user;



    $scope.create_answer = function(){
      var params = $.extend({target_id: $routeParams.id}, $scope.answer)

      $http.post('/posts/answer', params)
      .success(function(data){
        add_answer(data['answer']);
        update_user(data['answer']);
      }).error(function(data){
        alert.error(data);
      });
    }




    // Paging
    $scope.prev = function(){
      if ($scope.is_prev()) {
        $scope.pager.current_page -= 1;
        load_answers();  
      }
    }

    $scope.is_prev = function(){
      return ($scope.pager.current_page > 1);
    }


    $scope.next = function(){
      if ($scope.is_next()) {
        $scope.pager.current_page += 1;
        load_answers();
      }
    }

    $scope.is_next = function(){
      return ($scope.pager.current_page < $scope.pager.count_pages);
    }




    // View Helper
    $scope.disable_class = function(use){
      return use ? '' : 'disabled';
    }


    function load_answers(){
      $http.get('/posts/answer_list?' + $.param({
        target_id: $routeParams.id,
        page: $scope.pager.current_page
      })).success(function(data){
        $scope.answers = data['items'];
        $scope.pager = data;
      }).error(function(data){
        alert.error(data);
        $scope.answers = [];
      });
    }



    function add_answer(answer){
      var pager = $scope.pager;

      $scope.answers.unshift(answer);
      pager.count += 1;
      pager.count_pages = Math.ceil(pager.count / pager.perpage);

      if ($scope.answers.length > pager.perpage) {
        $scope.answers.pop();
      }

      $scope.answer = {language: 'markdown'};
    }



    function update_user(answer){
      var cu = window.current_user;

      if (is_login(answer.username)) {
        cu.role_name = 'Common';
        cu.username = answer.username;
        cu.email = answer.email;
      }
    }



    function is_login(username) {
      return (
        window.current_user.role_name == 'Guest' &&
        username != window.current_user.username
      );
    }
  }
  
});
