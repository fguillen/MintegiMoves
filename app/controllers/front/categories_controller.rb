class Front::CategoriesController < Front::FrontController
  def show
    @category = Category.find(params[:id])
    @items = @category.items.by_position
  end
end
