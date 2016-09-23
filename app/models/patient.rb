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
  STATUS = [INITIAL, REFERRED, TREATMENT, CLOSED]

  MEDIC_RECORD_CODE_LENGTH = 6

  def full_name
    "#{last_name}, #{first_name} #{middle_name}"
  end

  def medic_record
    base_str = "MR"
    (MEDIC_RECORD_CODE_LENGTH - id.to_s.length).times { base_str << "0" }
    "#{base_str}#{id}"
  end

  def age
    ((Time.now - date_of_birth) / 1.years).to_i
  end

  def is_viewed_detail!(count = 1)
    self.viewed_count += count
    save!
  end
end
