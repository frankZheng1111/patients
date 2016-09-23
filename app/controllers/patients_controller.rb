class PatientsController < BaseController
  before_action :find_patient, only: [:show]

  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    patient_attributes = patient_params
    patient = Patient.create!(patient_attributes)
    redirect_to patient_path(patient)
  end

  def show
    @patient.is_viewed_detail!
  end

  private

  def find_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    patient_attributes = params.require(:patient).permit(
      :first_name,
      :middle_name,
      :last_name,
      :gender,
      :status,
      :location_id,
      :date_of_birth
    )
    patient_attributes[:date_of_birth] = Time.parse(patient_attributes[:date_of_birth])
    patient_attributes
  end
end
