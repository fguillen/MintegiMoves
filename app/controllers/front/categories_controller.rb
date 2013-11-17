class Front::CategoriesController < Front::FrontController
  def show
    @category = params[:id] ? Category.find(params[:id]) : Category.by_position.first
    @items = @category.items.by_position
  end
end
