module ApplicationHelper
  def menu_class(menus, actual_menu_name)
    path = request.fullpath.gsub(/\?.*/, "")

    return "active" if menus[actual_menu_name].to_a.any? { |e| path =~ /^#{e}$/ }
    return "no-active"
  end
end
