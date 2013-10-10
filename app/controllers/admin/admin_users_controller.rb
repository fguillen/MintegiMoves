class Admin::AdminUsersController < Admin::AdminController
  before_filter :require_admin_user, :except => [:reset_password, :reset_password_submit]

  def index
    @admin_users = AdminUser.all
  end

  def show
    @admin_user = AdminUser.find(params[:id])
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(params[:admin_user])
    if @admin_user.save
      redirect_to [:admin, @admin_user], :notice => "Successfully created AdminUser."
    else
      flash.now[:alert] = "Some error trying to create admin_user."
      render :action => 'new'
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(params[:admin_user])
      redirect_to [:admin, @admin_user], :notice  => "Successfully updated AdminUser."
    else
      flash.now[:alert] = "Some error trying to update AdminUser."
      render :action => 'edit'
    end
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    redirect_to :admin_admin_users, :notice => "Successfully destroyed AdminUser."
  end

  def reset_password
    @admin_user = AdminUser.find_using_perishable_token!(params[:reset_password_code], 1.week)
  end

  def reset_password_submit
    @admin_user = AdminUser.find_using_perishable_token!(params[:reset_password_code], 1.week)

    if @admin_user.update_attributes(params[:admin_user])
      AdminUserSession.create(@admin_user)
      flash[:notice] = "Password reseted, you have been authenticated!"
      redirect_back_or_default admin_root_path
    else
      flash.now[:alert] = "Some errors trying to reset the password"
      render :reset_password
    end
  end
end
