




module Sky

  # Error types
  RUNING_TIME_ERROR = 'running_error'
  SKY_ERROR = 'sky_error'
  AUTH_ERROR = 'auth_error'
  NO_PERMISSION_ERROR = 'no_permission_error'



  # ext standard error
  class ::StandardError
    def error_type
      @error_type ||= RUNING_TIME_ERROR
    end


    def to_hash
      @eh ||= {
        :error => error_type,
        :error_desc => message
      }
    end
  end





  ########################################
  #
  #  自定义错误
  #
  ########################################
  class SkyError < ::StandardError
    def initialize(msg)
      super

      @error_type = SKY_ERROR
    end
  end




  class AuthError < SkyError
    def initialize
      @error_type = NO_PERMISSION_ERROR

      super 'Username Password does not match.'
    end
  end



  class NoPermissionError < SkyError
    def initialize
      @error_type = AUTH_ERROR

      super 'User does not have permission to operate.'
    end
  end


  class ArgumentError < SkyError
    def initialize(name, val)
      super "Argument '#{name}' invalid, value can no be '#{val}'."
    end
  end

end
