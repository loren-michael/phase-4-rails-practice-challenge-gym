class ClientsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    clients = Client.all
    render json: clients, include: [ :gyms, :memberships ]
  end

  def show
    client = find_client
    render json: client, include: [ :gyms, :memberships ], methods: [ :total_membership_cost ]
  end

  def create
    client = Client.create(client_params)
    if client.valid?
      render json: client, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    client = find_client
    if client
      client.update(client_params)
      render json: client, include: [ :gyms, :memberships ], status: :accepted
    end
  end

  def destroy
    client = find_client
    if client
      client.destroy
      render json: { message: "This client has been deleted." }
    end
  end

  private

  def find_client
    client = Client.find(params[:id])
  end

  def client_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Client not found" }, status: 404
  end
end
