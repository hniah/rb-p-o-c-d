module ApplicationHelper
  def display_active_menu_item(page_url)
    current_page?(page_url) ? 'active' : ''
  end

  def page_title(separator = " – ")
    [content_for(:title), 'Our Cleaning Department'].compact.join(separator)
  end

  def page_heading(title)
    content_for(:title){ title }
    content_tag(:h1, title)
  end
end
