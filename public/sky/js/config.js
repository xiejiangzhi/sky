

(function(){
  seajs.config({
    baseUrl: '/public',
    paths: {
      'angular': '/public/angular-1.0.7',
      'sky_ctrl': '/public/sky/js/controllers',
      'components': '/public/sky/js/components',

      'bootstrap': '/public/bootstrap/js',

      'lib': '/public/lib'
    },


    alias: {
      'sky': '/public/sky/js/sky.js',
      'angular': 'angular/angular.js',
      'sea_angular': '/public/sky/js/sea_angular.js',


      'jquery': 'lib/jquery-2.0.3.js',
      'markdown': 'lib/markdown.js',
      'md5': 'lib/md5.min.js',



      'components.alert': 'bootstrap/alert.js',
      'preview_html': 'components/preview_html.js',
      

      'waterfall_stream': 'components/waterfall_stream',
      


      'home': 'sky_ctrl/home.js',
      'posts': 'sky_ctrl/posts.js',
      'post_show': 'sky_ctrl/post_show.js',
      'post_edit': 'sky_ctrl/post_edit.js',
      

      'alert': 'components/alert.js'
    },
  });
}());

