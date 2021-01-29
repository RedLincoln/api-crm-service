class Api::V1::CustomersController < ApplicationController

  def index
    render json: { customers: Customer.all.map { |customer| link_photo(customer)} }
  end

  def show
    begin
      customer = Customer.find(params['id'])  
      render json: { customer: customer }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Customer not found'}, status: :not_found
    end
  end

  def create

  end

  def update

  end

  def destroy

  end


  private

  def link_photo(customer)
    customer.as_json.tap do |hash|
      hash['photo'] = customer.photo.attached? ? url_for(customer.photo) : nil
    end
  end
end
