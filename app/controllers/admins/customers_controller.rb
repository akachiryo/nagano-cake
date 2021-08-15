class Admins::CustomersController < ApplicationController

def index
   @customers = Customer.page(params[:page]).reverse_order
end

def show
  @customer=Customer.find(params[:id])
end

def edit
end





end

