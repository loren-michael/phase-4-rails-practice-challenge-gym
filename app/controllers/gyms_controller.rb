class GymsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    gyms = Gym.all
    render json: gyms, include: [ :memberships ]
  end

  def show
    gym = find_gym
    render json: gym, include: [ :memberships ]
  end

  def create
    gym = Gym.create(gym_params)
    if gym.valid?
      render json: gym, status: :created
    end
  end

  def update
    gym = find_gym
    gym.update(gym_params)
    render json: gym, include: [ :memberships ]
  end

  def destroy
    gym = find_gym
    if gym
      gym.destroy
      render json: {}, status: :accepted
    end
    
  end

  private

    def find_gym
      gym = Gym.find(params[:id])
    end

    def gym_params
      params.permit(:name, :address)
    end

    def render_not_found_response
      render json: { errors: gym.errors.full_messages }, status: :not_found
    end

end
