
define(function(require, exports){
  exports.to_html = function(post, limit){
    var content = post.content || "";

    if (limit && post.view_status == null) {
      content = content.split("<!--SPLIT-->")[0];
    }

    switch (post.language) {
    case 'markdown':
      require("markdown");
      return markdown.toHTML(content);
    case 'html':
      return content;
    case 'text':
      require("jquery");

      return $("<div />").text(content).html();
    default:
      return content;
    }
  }
});
