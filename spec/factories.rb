FactoryGirl.define do
  factory :location do
    id 111
    name "Test location"
    code "code"
  end

  factory :patient do
    id 222
    first_name "a"
    middle_name "b"
    last_name "c"
    date_of_birth Time.now - 20.years
    gender "male"
    status "initial"
    location_id 111
  end
end
