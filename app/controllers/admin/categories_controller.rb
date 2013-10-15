class Admin::CategoriesController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_category, :only => [:show, :edit, :update, :destroy, :log_book_events]

  def show
  end

  def edit
  end

  def update
    @category.log_book_historian = current_admin_user
    if @category.update_attributes(params[:category])
      redirect_to [:admin, @category], :notice  => "Successfully updated Category."
    else
      flash.now[:alert] = "Some error trying to update Category."
      render :action => 'edit'
    end
  end

  def log_book_events
    @log_book_events = @category.log_book_events.by_recent.paginate(:page => params[:page], :per_page => 10)
  end

private

  def load_category
    @category = Category.find(params[:id])
  end
end
