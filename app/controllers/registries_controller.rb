class RegistriesController < ApplicationController
before_action :set_registry, only: [:show, :update, :destroy]

  def index
    if params[:filter].present?
        filter = params[:filter]
        @registries = Registry.where("source LIKE ?", "%#{filter}%")
    else
        @registries = Registry.all
    end
        render json: @registries
  end

  def show
    render json: @registry
  end

  def create
    @registry = Registry.new(registry_params)

    if @registry.save
      render json: @registry, status: :created, location: @registry
    else
      render json: @registry.errors, status: :unprocessable_entity
    end
  end

  def update
    if registry_params.key?(:status)
      status_key = registry_params[:status]
      unless Registry.statuses.key?(status_key)
        return render json: { error: "Invalid status" }, status: :unprocessable_entity
      end
    end

    if @registry.update(registry_params)
      render json: @registry
    else
      render json: @registry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @registry.destroy
  end

  private

  def set_registry
    @registry = Registry.find(params[:id])
  end

  def registry_params
    params.require(:registry).permit(:source, :destination, :status, :confidential, :created_at, :updated_at)
  end
end
