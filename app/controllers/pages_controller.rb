class PagesController < ApplicationController

  def job_scope_and_time_to_task
    @page = Page.find_by_alias('job_scope_and_time_to_task')
    render :job_scope_and_time_to_task
  end

  def terms_and_condition
    @page = Page.find_by_alias('terms_and_condition')
    render :terms_and_condition
  end

  def disclaimer_privacy_policy
    @page = Page.find_by_alias('disclaimer_privacy_policy')
    render :disclaimer_privacy_policy
  end

  def faq
    @page = Page.find_by_alias('faq')
    render :faq
  end

  def join_us
    @page = Page.find_by_alias('join_us')
    render :join_us
  end
end
