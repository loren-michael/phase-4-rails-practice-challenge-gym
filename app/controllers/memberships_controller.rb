class MembershipsController < ApplicationController
  
  def index
    memberships = Membership.all
    render json: memberships, include: [ :gym, :client ]
  end

  def show
    membership = find_membership
    render json: membership, include: [ :gym, :client ]
  end

  def create
    membership = Membership.create(membership_params)
    if membership.valid?
      render json: membership, status: :created
    else
      render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    membership = find_membership
    if membership
      membership.update(membership_params)
      render json: membership, include: [ :gym, :client ], status: :accepted
    end
  end

  def destroy
    membership = find_membership
    if membership
      membership.destroy
      render json: { message: "This membership has been cancelled." }, status: :accepted
    end
  end

  private
  
    def membership_params
      params.permit(:charge, :client_id, :gym_id)
    end

    def find_membership
      membership = Membership.find(params[:id])
    end

end
