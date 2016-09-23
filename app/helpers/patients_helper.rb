module PatientsHelper
  def can_view_detail? (controller, action)
    "patients" == controller && "index" == action
  end

  def can_delete_patient?(controller, action)
    "patients" == controller &&
    "index" == action ||
    "show" == action
  end
end
