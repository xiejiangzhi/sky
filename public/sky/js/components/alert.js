
define(function(require, exports){
  
  var store = {};


  exports.success = function(title, desc){
    show('success', title, desc);
  }


  exports.info = function(title, desc){
    show('info', title, desc);
  }


  exports.warn = function(title, desc){
    show('', title, desc);
  }


  exports.error = function(title, desc){
    show('error', title, desc);
  }

  



  exports.ctrl = function($scope){
    store.$scope = $scope;

    $scope.error = null

    $scope.alert = exports.alert;
  }





  function show(type, title, description){
    if (!store.$scope) {
      setTimeout(function(){
        show(type, title, description);
      }, 500);
      return ;
    }

    store.$scope.error = {
      type: type,
      title: title,
      description: description
    }

    store.$scope.$apply();
  };
});
