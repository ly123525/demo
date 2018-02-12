class Admin::BaseController < ActionController::Base
  layout 'admin/layouts/admin'
  before_action :auth_user_is_admin
  def auth_user_is_admin
    if current_user
    unless current_user.is_admin?
      redirect_to new_admin_session_path, notice: '请以管理员身份登陆！'
    end
    else
      redirect_to new_admin_session_path, notice: '请以管理员身份登陆！'
    end
  end

end