class Location < ActiveRecord::Base
  has_many :patients

  validates :name, presence: true,
                   length: { maximum: 80 }
  validates_length_of :code, maximum: 10

  def not_deleted_patients
    patients.not_deleted
  end
end
