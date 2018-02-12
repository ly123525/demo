class Admin::SessionsController < Admin::BaseController
  layout 'session'
  skip_before_action :auth_user_is_admin
  def new

  end

  def create
     user = login(params[:email], params[:password])
    if user && user.is_admin?
      redirect_to admin_root_path, notice: '登陆成功！'
    else
      redirect_to new_admin_session_path, alert: '账户密码不正确！'
    end
  end

  def destroy
    logout
    redirect_to new_admin_session_path, :notice=>'安全退出！'
  end
end