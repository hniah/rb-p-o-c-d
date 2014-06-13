module Concerns::Users::Redirection
  extend ActiveSupport::Concern

  included do
    def redirect_to_user_new_promotion_path(message)
      flash[:alert] = message
      redirect_to user_new_promotion_path
    end
  end
end
