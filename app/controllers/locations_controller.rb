class LocationsController < BaseController
  before_action :find_location, only: [:show]

  def show
    @patients = @location.not_deleted_patients
  end

  private

  def find_location
    @location = Location.find(params[:id])
  end
end
