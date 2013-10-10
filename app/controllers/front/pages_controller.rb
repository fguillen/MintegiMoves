class Front::PagesController < Front::FrontController
  def show
    render "front/pages/#{params[:id]}"
  end
end