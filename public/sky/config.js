

(function(){
  var baseUrl = '/public/';

  

  function angular_file(path){
    return file('angular-1.0.7/' + path);
  }

  function sky_ctrl(path){
    return file('sky/controllers/' + path);
  }


  seajs.config({
    baseUrl: '/public',
    paths: {
      'sky': '/public/sky',
      'sky_ctrl': '/public/sky/controllers'
    },

    alias: {
      'home': 'sky_ctrl/home.js',
      'blog/posts/index': 'sky_ctrl/blog.js',
      'blog/posts/edit': 'sky_ctrl/blog/posts/edit.js',
      'blog/posts/create': 'sky_ctrl/blog/posts/create.js'
    },
  });
}());

