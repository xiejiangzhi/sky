


module Models; class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  # content language
  TEXT      = 'text'
  MARKDOWN  = 'markdown'
  HTML      = 'html'



  field :title,     :type => String
  field :content,   :type => String
  field :language,      :type => String, :default => MARKDOWN

  default_scope order_by(:created_at => -1)

end; end
