class Admin::ItemsController < Admin::AdminController
  before_filter :require_admin_user
  before_filter :load_item, :only => [:show, :edit, :update, :destroy, :log_book_events]

  def index
    @category = params[:category_id] ? Category.find(params[:category_id]) : Category.first
    @items = Item.by_position.where(:category_id => @category.id)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.log_book_historian = current_admin_user
    if @item.save
      redirect_to [:admin, @item], :notice => "Successfully created Item."
    else
      flash.now[:alert] = "Some error trying to create item."
      render :action => :new
    end
  end

  def edit
  end

  def update
    @item.log_book_historian = current_admin_user
    if @item.update_attributes(item_params)
      redirect_to [:admin, @item], :notice  => "Successfully updated Item."
    else
      flash.now[:alert] = "Some error trying to update Item."
      render :action => :edit
    end
  end

  def destroy
    @item.log_book_historian = current_admin_user
    @item.destroy
    redirect_to :admin_items, :notice => "Successfully destroyed Item."
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      Item.find(id).update!(:position => index)
    end

    render :json => { "status" => "ok" }
  end

  def log_book_events
    @log_book_events = @item.log_book_events.by_recent.paginate(:page => params[:page], :per_page => 10)
  end

private

  def load_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit!
  end
end
