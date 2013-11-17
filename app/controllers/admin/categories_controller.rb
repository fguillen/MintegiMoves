class Admin::CategoriesController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_category, :only => [:show, :edit, :update, :destroy, :log_book_events]

  def index
    @categories = Category.by_position
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.log_book_historian = current_admin_user
    if @category.save
      redirect_to [:admin, @category], :notice => "Successfully created Category."
    else
      flash.now[:alert] = "Some error trying to create category."
      render :action => :new
    end
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

  def destroy
    @category.log_book_historian = current_admin_user
    @category.destroy
    redirect_to :admin_categories, :notice => "Successfully destroyed Category."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      Category.update_all(["position=?", index], ["id=?", id])
    end
    render :json => { "status" => "ok" }
  end

  def log_book_events
    @log_book_events = @category.log_book_events.by_recent.paginate(:page => params[:page], :per_page => 10)
  end

private

  def load_category
    @category = Category.find(params[:id])
  end
end
