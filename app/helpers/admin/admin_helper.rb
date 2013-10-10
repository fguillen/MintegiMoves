module Admin::AdminHelper
  include ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert
        "alert alert-danger"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end

  def admin_menu_class(actual_menu_name)
    menus = {
      :admin_users => ["/admin/admin_users.*"],
      :items => ["/admin/items.*", "/admin"],
      :log_book_events => ["/admin/log_book_events"],
      :item_log_book_events => ["/admin/items/.+/log_book_events"],
      :item_info => ["/admin/items/[^/]+"]
    }

    menu_class(menus, actual_menu_name)
  end

  def render_label(word, palette_name)
    StylePalette::Helper.label(word, palette_name).html_safe
  end

  def render_labels(words, palette_name)
    words.map { |e| render_label e, palette_name }.join(" ").html_safe
  end
end
