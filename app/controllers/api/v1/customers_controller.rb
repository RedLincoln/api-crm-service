class Api::V1::CustomersController < ApplicationController

  def index
    render json: { customers: Customer.all }
  end

  def show
    
  end

  def create

  end

  def update

  end

  def destroy

  end
end
