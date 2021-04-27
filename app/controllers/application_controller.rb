class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  before_action :set_admin_search

  protected
    # 会員側の検索ページ
  def set_search
    # 商品検索
    @search = Product.ransack(params[:q])#ransackメソッド推奨
    @search_products = @search.result.page(params[:page])
  end
    # 管理者側の検索ページ
  def set_admin_search
    # 会員検索
    @search_q = Customer.ransack(params[:q])
    @search_customers = @search_q.result.page(params[:page])
  end



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
