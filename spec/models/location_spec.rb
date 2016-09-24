require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "About Location Dynamic Properties" do
    before do
      @location = create(:location)
      @patient1 = create(:patient, id: 1, location_id: @location.id)
      @patient2 = create(:patient, id: 2, is_deleted: true, location_id: @location.id)
    end

    it "should return patient's full name" do
      expect(@location.not_deleted_patients.size).to eql(1)
      expect(@location.not_deleted_patients.first.id).to eql(1)
    end
  end
end
