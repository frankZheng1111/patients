class Patient < ActiveRecord::Base
  belongs_to :location

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
end
