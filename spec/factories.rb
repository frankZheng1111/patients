FactoryGirl.define do
  factory :location do
    name "Test location"
    code "Test location code"
  end

  factory :patient do
    id 222
    first_name "a"
    middle_name "b"
    last_name "c"
    date_of_birth Time.now - 20.years
    gender "male"
    status "initial"
  end
end
