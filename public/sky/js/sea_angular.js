
define(function(require, exports){
  
  exports.autoload = function() {
    var modules = format_args(arguments)
    var injector = ['$scope'];
    var bak = injector.slice(0, injector.length);


    bak.push('$injector');

    bak.push(function() {
      var $injector = arguments[arguments.length - 1];
      var inject_opts = {};
      var that = this;

      for (var i = 0; i < injector.length; i++) {
        inject_opts[injector[i]] = arguments[i];
      }


      seajs.use(modules, function(m) {
        $injector.invoke(m.ctrl, that, inject_opts);
      });
    });

    return bak;
  }


  // 主要用来区别js与css
  // xxx 默认为seajs的加载
  // xxx.js  为js
  // xxx.css 为css
  function format_args(args) {
    var tmp = [];

    for (var i = 0; i < args.length; i++){
      switch (args[i].split('.')[1]) {
      case 'js':
        tmp.push('/public/' + args[i]);
        break;
      case 'css':
        tmp.push('/stylesheets/' + args[i]);
        break;
      default:
        tmp.push(args[i]);
      }
    }

    return tmp;
  }
});
