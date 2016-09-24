class Location < ActiveRecord::Base
  has_many :patients

  def not_deleted_patients
    patients.not_deleted
  end
end
