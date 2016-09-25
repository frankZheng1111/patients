module PatientsHelper
  # patient/show 页面不需要显示view detail链接
  def can_view_detail? (controller, action)
    "patients" != controller || "show" != action
  end

  # location/show 页面不需要显示location链接
  def show_location_link?(controller, action)
    "locations" != controller || "show" != action
  end
end
