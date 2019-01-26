class Admin::PicsController < Admin::AdminController
  before_filter :load_picable

  def index
    @pics = @picable.pics.by_position
    render :json => @pics.map(&:to_json)
  end

  def create
    @pic = @picable.pics.create!(:attach => params[:file])
    render :json => @pic.to_json
  end

  def destroy
    @pic = @picable.pics.find(params[:id])
    @pic.destroy
    render :json => { "status" => "ok" }
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      @picable.pics.find(id).update!(:position => index)
    end

    render :json => { "status" => "ok" }
  end

  private

  def load_picable
    @picable = Item.find(params[:item_id])          if params[:item_id]
    @picable = Category.find(params[:category_id])  if params[:category_id]
  end
end
