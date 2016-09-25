class PatientsController < BaseController
  before_action :get_prev, only: [:show, :create, :update]
  before_action :find_patient, only: [:show, :destroy, :edit, :update]

  def index
    @patients = Patient.not_deleted.includes(:location)
  end

  def new
    @patient = Patient.new
  end

  def create
    patient_attributes = patient_params
    # 验证失败会捕获抛出异常，通过flash显示验证失败信息
    @patient = Patient.create!(patient_attributes)
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    puts params
    patient_attributes = patient_params
    @patient.update!(patient_attributes)
    redirect_to patient_path(@patient)
  end

  def show
    # 切换中英文不计入浏览次数
    @patient.is_viewed_detail! unless "show" == @prev[:action] && "patients" == @prev[:controller]
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

  def get_prev
    @prev = Rails.application.routes.recognize_path(request.referrer)
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
