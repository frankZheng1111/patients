class PatientsController < BaseController
  before_action :find_patient, only: [:show, :destroy, :edit, :update]

  def index
    @patients = Patient.not_deleted
  end

  def new
    @patient = Patient.new
  end

  def create
    patient_attributes = patient_params
    @patient = Patient.new(patient_attributes)
    @patient.save!
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    puts params
    patient_attributes = patient_params
    @patient.assign_attributes(patient_attributes)
    @patient.save!
    redirect_to patient_path(@patient)
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
    if patient_attributes[:date_of_birth].present?
      patient_attributes[:date_of_birth] = Time.parse(patient_attributes[:date_of_birth])
    end
    [:first_name, :middle_name, :last_name].map do |name|
      patient_attributes[name].strip!
    end
    patient_attributes
  end
end
