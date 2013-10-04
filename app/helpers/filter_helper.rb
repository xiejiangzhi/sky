
module FilterHelper

  def auth_permissio_filter
    unless current_user.can?(:create, Post)
      halt render_err('auth_failed', 'no permission operating')
    end
  end

end
