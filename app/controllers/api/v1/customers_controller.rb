class Api::V1::CustomersController < ApplicationController
  before_action :authenticate

  def index
    render json: { customers: Customer.all.map { |customer| link_photo(customer)} }
  end

  def show
    begin
      customer = Customer.find(params['id'])  
      render json: { customer: link_photo(customer) }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Customer not found'}, status: :not_found
    end
  end

  def create
    customer = Customer.new(customer_params.merge({ creator: @user, modifier: @user }))
    if customer.save
      render json: { customer: link_photo(customer) }, status: :created
    else
      render json: { error: 'Bad Request' }, status: :bad_request
    end
  end

  def update
    begin
      customer = Customer.find(params['id'])
      customer.update(customer_params.merge(modifier: @user))
      render json: { customer: link_photo(customer)}, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Not Found'}, status: :not_found
    end
  end

  def destroy
    begin
      customer = Customer.find(params['id'])
      customer.destroy
      render json: { customer: link_photo(customer)}, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Not Found'}, status: :not_found
    end
  end


  private

  def link_photo(customer)
    customer.as_json.tap do |hash|
      hash['photo'] = customer.photo.attached? ? url_for(customer.photo) : nil
    end
  end

  def customer_params
    params.permit(:name, :surname, :photo)
  end
end
