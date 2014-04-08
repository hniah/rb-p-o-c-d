module ApplicationHelper
  def display_active_menu_item(page_url)
    current_page?(page_url) ? 'active' : ''
  end
end
