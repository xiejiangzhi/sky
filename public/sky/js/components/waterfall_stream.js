
define(function(require, exports){
  require('jquery');


  var $win = $(window);
  var $doc = $(document);


  var config = { stop: false };



  exports.callback = function(){}



  $win.scroll(function(){
    init_config();

    if ($win.scrollTop() >= config.max_scroll && config.stop != true) {
      config.stop = true;

      exports.callback(function(){ config.stop = false; });
    }
  });



  function init_config(){
    config.win_height = $win.height();
    config.doc_height = $doc.height();
    config.max_scroll = config.doc_height - config.win_height - 100;
  }
});
