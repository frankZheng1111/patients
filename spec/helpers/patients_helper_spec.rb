require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PatientsHelper. For example:
#
# describe PatientsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PatientsHelper, type: :helper do
  describe "it should judge whether to show specific col" do
    it "should to show view detail" do
      expect(can_view_detail?("patients", "index")).to eql(true)
      expect(can_view_detail?("patients", "show")).to eql(false)
    end

    it "should to show location link" do
      expect(show_location_link?("patients", "index")).to eql(true)
      expect(show_location_link?("locations", "show")).to eql(false)
    end
  end
end
