require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "About Dynamic Properties" do
    before do
      @patient1 = build(:patient)
      @patient2 = build(:patient, id: 1234567)
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

  describe "About scope" do
    it "should return patients status=treatment" do
      @patient1 = create(:patient)
      @patient1 = create(:patient, id: 2, status: "treatment")
      expect(Patient.on_treatment.size).to eql(1)
      expect(Patient.on_treatment.first.id).to eql(2)
    end
  end

  describe "About Patient CRUD methods" do
    before do
      @patient1 = create(:patient)
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

