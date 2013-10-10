class Front::ItemsController < Front::FrontController
  def show
    @item = Item.find(params[:id])
  end
end
