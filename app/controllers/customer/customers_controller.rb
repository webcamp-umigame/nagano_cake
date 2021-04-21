class Customer::CustomersController < ApplicationController
  
  def edit
    @customer = current_customer
  end
	
  def show
    @customer = current_customer
  end

	def unsubscribe
	  @customer = current_customer
	end
	
	def update
	  @customer = current_customer
	  if @customer.update(customer_params)
    flash[:success] = "登録情報を変更しました"
      redirect_to customer_params
	  else
      render :edit and return
    end
  end
  
	
	def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
	end

	private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
  end
end
