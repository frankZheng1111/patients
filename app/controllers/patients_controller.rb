class PatientsController < BaseController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    patient_attributes = patient_params
    Patient.create!(patient_attributes)
    redirect_to patients_path
  end

  private

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
