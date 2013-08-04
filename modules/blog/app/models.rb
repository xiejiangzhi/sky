

POST = MongoDatabase['posts']

class Post; class << self
  def create(attrs)
    POST.insert(safe_attrs(attrs))
  end



  def update(id, attrs)
    id = BSON::ObjectId(id) unless BSON::ObjectId === id

    

    POST.update({'_id' => id}, {
      '$set' => safe_attrs(attrs)
    })
  end


  def safe_attrs(attrs)
    attrs.each_with_object({}) do |kv, result|
      key, val = kv

      case key
      when 'title', 'content'
        result[key] = val
      when 'user_id'

      end
    end
    
  end
end; end
