class UsersController < ApplicationController
  before_action :authenticate_user!

  include Concerns::Users::Redirection

  def info
  end

  def new_promotion
    render :promotion
  end

  def add_promotion
    promotion_code = PromotionCode.find_by_code(code_param['code'])

    @service = User::CreationService.new(self)
    @service.execute!(promotion_code, current_user)

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to user_new_promotion_path
  end

  def add_promotion_code_successful
    flash[:notice] = "Your promotion code has been accepted."
    redirect_to user_info_path
  end

  protected
  def code_param
    params.permit(:code)
  end
end
