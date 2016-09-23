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
      expect(@patient1.full_name).to eql("c, a b")
    end

    it "should return patient's MR" do
      expect(@patient1.medic_record).to eql("MR000222")
      expect(@patient2.medic_record).to eql("MR1234567")
    end

    it "should return patient's age" do
      expect(@patient1.age).to eql(20)
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

    it "should set patient is deleted" do
      @patient1.delete_patient!
      expect(@patient1.is_deleted).to eql(true)
    end

    it "should add viewed_count" do
      expect(@patient1.viewed_count).to be(0)
      expect { @patient1.is_viewed_detail! }.
        to change(@patient1, :viewed_count).by(1)
      expect { @patient1.is_viewed_detail!(999999998) }.
        to change(@patient1, :viewed_count).by(999999998)
    end
  end
end

