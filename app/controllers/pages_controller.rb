class PagesController < ApplicationController

  def job_scope_and_time_to_task
    @page = Page.find_by_article_alias('job_scope_and_time_to_task')
    render :info
  end

  def terms_and_condition
    @page = Page.find_by_article_alias('terms_and_condition')
    render :info
  end

  def disclaimer_privacy_policy
    @page = Page.find_by_article_alias('disclaimer_privacy_policy')
    render :info
  end

  def faq
    @page = Page.find_by_article_alias('faq')
    render :info
  end

  def about_us
    @page = Page.find_by_article_alias('about_us')
    render :info
  end

  def join_us
    @page = Page.find_by_article_alias('join_us')
    render :info
  end

  def sitemap
    @page = Page.find_by_article_alias('sitemap')
    render :info
  end

  def tips_buy_package
    @page = Page.find_by_article_alias('tips_buy_package')
    render :info
  end

  def tips_booking
    @page = Page.find_by_article_alias('tips_booking')
    render :info
  end

  def tips_new_booking
    @page = Page.find_by_article_alias('tips_new_booking')
    render :info
  end

  def tips_user
    @page = Page.find_by_article_alias('tips_user')
    render :info
  end

  def show
    @page = Page.find(page_id_param)
    render :info
  end


  private
  def page_id_param
    params.require(:id)
  end
end
