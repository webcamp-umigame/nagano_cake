class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!

  protected
  def after_sign_in_path_for(resource)
    if customer_signed_in?
      customers_path(resource)
    else
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
