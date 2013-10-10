class Admin::LogBookEventsController < Admin::AdminController
  before_filter :require_admin_user

  def index
    @log_book_events = LogBook::Event.by_recent.paginate(:page => params[:page], :per_page => 10)
  end
end
