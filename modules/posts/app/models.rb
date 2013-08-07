


module Models; class Post
  include Mongoid::Document
  include Mongoid::Timestamps


  field :title,   :type => String
  field :content, :type => String

  default_scope order_by(:created_at => -1)

end; end
