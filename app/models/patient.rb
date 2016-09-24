class Patient < ActiveRecord::Base
  belongs_to :location

  MALE = "male"
  FEMALE = "female"
  NOT_AVAILABLE = "not_available"
  GENDERS = [MALE, FEMALE, NOT_AVAILABLE]

  INITIAL = "initial"
  REFERRED = "referred"
  TREATMENT = "treatment"
  CLOSED = "closed"
  STATUSES = [INITIAL, REFERRED, TREATMENT, CLOSED]

  MEDIC_RECORD_CODE_LENGTH = 6

  validates :first_name, presence: true,
                         length: { maximum: 30 }
  validates :last_name, presence: true,
                        length: { maximum: 30 }
  validates :status, presence: true,
                     inclusion: { in: STATUSES }
  validates_length_of :middle_name, maximum: 10
  validates_inclusion_of :gender, in: GENDERS
  validates_presence_of :location_id

  after_initialize :set_default_values

  scope :not_deleted, -> {
    where.not(is_deleted: true)
  }

  scope :on_treatment, -> {
    where(status: TREATMENT)
  }

  def full_name
    "#{last_name}, #{first_name} #{middle_name}"
  end

  def medic_record
    base_str = "MR"
    (MEDIC_RECORD_CODE_LENGTH - id.to_s.length).times { base_str << "0" }
    "#{base_str}#{id}"
  end

  def age
    return unless date_of_birth.present?
    ((Time.now - date_of_birth.to_time) / 1.years).to_i
  end

  def is_viewed_detail!(count = 1)
    self.viewed_count += count
    save!
  end

  def delete_patient!
    self.is_deleted = true
    save!
  end

  private

  def set_default_values
    self.gender ||= NOT_AVAILABLE
  end
end
