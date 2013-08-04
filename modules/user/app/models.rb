

USER = MongoDatabase['users']

class User; class << self
  def create(attrs)
    USER.insert(safe_attrs(attrs))
  end



  def update(id, attrs)
    id = BSON::ObjectId(id) unless BSON::ObjectId === id

    

    USER.update({'_id' => id}, {
      '$set' => safe_attrs(attrs)
    })
  end


  def safe_attrs(attrs)
    attrs.each_with_object({}) do |kv, result|
      key, val = kv

      case key
      when 'name', 'email'
        result[key] = val
      end
    end
    
  end
end; end
