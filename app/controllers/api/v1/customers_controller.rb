class Api::V1::CustomersController < ApplicationController
  before_action :authenticate
  load_and_authorize_resource
  

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Not Found'}, status: :not_found
  end

  def index
    @customers = Customer.all.map { |customer| link_photo(customer) }
    render json: { customers: @customers} 
  end

  def show
    @customer = Customer.find(params['id'])  
    render json: { customer: link_photo(@customer) }
  end

  def create
    @customer = Customer.new(customer_params.merge({ creator: @user, modifier: @user }))
    if @customer.save
      render json: { customer: link_photo(@customer) }, status: :created
    else
      render json: { error: 'Bad Request' }, status: :bad_request
    end
  end

  def update
    @customer = Customer.find(params['id'])
    @customer.update(customer_params.merge(modifier: @user))
    render json: { customer: link_photo(@customer)}, status: :ok
  end

  def destroy
    @customer = Customer.find(params['id'])
    @customer.delete
    render json: { message: 'Customer destroyed' }
  end

  

  private

  def current_ability
    @current_ability ||= CustomerAbility.new(@user)  
  end

  def link_photo(customer)
    customer.as_json.tap do |hash|
      hash['photo'] = customer.photo.attached? ? url_for(customer.photo) : nil
    end
  end

  def customer_params
    params.permit(:name, :surname, :photo)
  end
end
