

(function(){
  seajs.config({
    baseUrl: '/public',
    paths: {
      'sky': '/public/sky',
      'sky_ctrl': '/public/sky/controllers',
      'jquery': '/public/jquery'
    },

    alias: {
      'jquery': 'jquery/core.js',
      'jquery.serialize': 'jquery/serialize.js',
      
      'home': 'sky_ctrl/home.js',
      'posts': 'sky_ctrl/posts.js'
    },
  });
}());

