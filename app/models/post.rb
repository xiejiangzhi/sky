


class Post
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
  default_scope where(:parent => nil)


  has_many :posts, :class_name => 'Post', :inverse_of => :parent
  belongs_to :parent, :class_name => 'Post', :inverse_of => :posts

  belongs_to :user

end
