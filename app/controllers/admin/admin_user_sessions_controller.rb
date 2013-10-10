class Admin::AdminUserSessionsController < Admin::AdminController
  layout "admin/admin_basic"

  def new
    @admin_user_session = AdminUserSession.new
  end

  def create
    @admin_user_session = AdminUserSession.new(params[:admin_user_session])

    if @admin_user_session.save
      flash[:notice] = "Admin User authenticated!"
      redirect_back_or_default admin_root_path
    else
      flash[:alert] = "Not possible to authenticate"
      render action: "new"
    end
  end

  def destroy
    @admin_user_session = AdminUserSession.find
    @admin_user_session.destroy if @admin_user_session

    redirect_to admin_login_path, :notice => "Admin User logged out!"
  end

  def forgot_password
    @admin_user_session = AdminUserSession.new
  end

  def forgot_password_send_email
    admin_user = AdminUser.find_by_email( params[:admin_user_session][:email] )

    if admin_user
      admin_user.send_reset_password_email
      redirect_to admin_forgot_password_path, :notice => "Instructions to reset your password have been sent to your email"
    else
      redirect_to admin_forgot_password_path, :alert => "We can't find the email '#{params[:admin_user_session][:email]}'"
    end
  end
end