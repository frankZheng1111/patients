class PatientsController < BaseController
  def index
    @patients = Patient.all
  end
end
