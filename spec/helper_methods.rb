
module HelperMethods
  def valid_session(opts = {})
    {
      'rack.session' => opts
    }
  end


  def get_user(name, role = User::COMMON, ext = {})
    User.where(:username => name).first ||
    User.create({
      :username => name,
      :email => "#{name}@email.com",
      :role => role
    }.merge!(ext))
  end


  def error_should(res, e)
    JSON(res.body) == e.to_hash.merge(:ok => false)
  end



  def send_test_req(params = {})
    self.send(
      spec_args[:req_method], spec_args[:path],
      params, spec_args[:req_session]
    )
  end
end
