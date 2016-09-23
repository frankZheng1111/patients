class PatientsController < BaseController
  before_action :find_patient, only: [:show, :destroy]

  def index
    @patients = Patient.not_deleted
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

  def destroy
    @patient.delete_patient!
    flash[:notice] = t("other.delete_success")
    redirect_to patients_path
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
    [:first_name, :middle_name, :last_name].map do |name|
      patient_attributes[name].strip!
    end
    patient_attributes
  end
end
