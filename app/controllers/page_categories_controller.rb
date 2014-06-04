class PageCategoriesController < ApplicationController
  def blogs
    @pages = PageCategory.find_by_page_category_alias('blogs').page.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 3)
    render :list
  end
end
