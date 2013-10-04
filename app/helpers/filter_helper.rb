
module FilterHelper

  def auth_permissio_filter
    unless current_user.can?(:create, Post)
      halt render_err Sky::NoPermissionError.new
    end
  end

end
