class Admin::PicsController < Admin::AdminController
  before_filter :load_item

  def index
    @pics = @item.pics.by_position
    render :json => @pics.map(&:to_json)
  end

  def create
    @pic = @item.pics.create!(:attach => params[:file])
    render :json => @pic.to_json
  end

  def destroy
    @pic = @item.pics.find(params[:id])
    @pic.destroy
    render :json => { "status" => "ok" }
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      @item.pics.update_all(["position=?", index], ["id=?", id])
    end
    render :json => { "status" => "ok" }
  end

  private

  def load_item
    @item = Item.find(params[:item_id])
  end
end
