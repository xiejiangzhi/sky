
module Sky; class Permissions
  def initialize(user)
    @user = user
  end


  def admin?
    @user.role == User::ADMIN
  end


  def can?(operat, resource)
    operat = operat.to_sym
    case resource
    when Post then can_manager_post?(operat, resource)
    when User then can_manager_user?(operat, resource)
    else admin?
    end
  end



  def can_manager_post?(operat, resource)
    case operat
    when :update
      admin? || resource.user_id == @user.id
    when :hidden
      admin?
    else true
    end
  end


  def can_manager_user?(operat, resource)
    admin?
  end
end; end
