require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "About Dynamic Properties" do
    before do
      @patient1 = Patient.new(
        id: 222,
        first_name: "a",
        middle_name: "b",
        last_name: "c",
        date_of_birth: Time.now - 20.years,
        gender: "male",
        status: "initial"
      )
      @patient2 = Patient.new(id: 1234567)
    end

    it "should return patient's full name" do
      @patient1.full_name.should === "c, a b"
    end

    it "should return patient's MR" do
      @patient1.medic_record.should === "MR000222"
      @patient2.medic_record.should === "MR1234567"
    end

    it "should return patient's age" do
       @patient1.age.should === 20
    end
  end

  describe "About Patient CRUD methods" do
    before do
      @patient1 = Patient.create(
        id: 222,
        first_name: "a",
        middle_name: "b",
        last_name: "c",
        date_of_birth: Time.now - 20.years,
        gender: "male",
        status: "initial"
      )
    end

    it "should add viewed_count" do
      @patient1.viewed_count.should === 0
      @patient1.is_viewed_detail!
      @patient1.viewed_count.should === 1
      @patient1.is_viewed_detail!(999999998)
      @patient1.viewed_count.should === 999999999
    end
  end
end
