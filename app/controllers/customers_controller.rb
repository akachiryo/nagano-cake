class CustomersController < ApplicationController
  #before_action :authenticate_customer!
  before_action :ensure_correct_user

  def show

  end

  def edit

  end

  def update

    if @customer.update(customer_params)
      redirect_to customer_path(current_customer), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def unsubscribe

  end

  def withdraw

    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email, :is_deleted)
    end

    def ensure_correct_user
      @customer = Customer.find(params[:id])
      if @customer != current_customer
        redirect_to root_path
      end
    end
end
