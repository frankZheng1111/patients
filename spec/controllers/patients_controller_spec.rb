require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  describe "About PatientsController CRUD" do
    before do
      create(:location)
      @patient = create(:patient)
    end

    it "should get index and show list" do
      get "index"
      expect(response).to render_template(:index)
      expect(assigns(:patients).size).to eq(1)
      expect(assigns(:patients).first.id).to eq(222)
    end

    it "should get new page" do
      get "new"
      expect(response).to render_template(:new)
      expect(assigns(:patient)).to be_instance_of(Patient)
    end

    it "should create_patient success" do
      post "create", {
        patient: {
          first_name: "new",
          middle_name: "",
          last_name: "b",
          status: "initial",
          gender: "male",
          location_id: 111
        }
      }
      expect(response).to redirect_to(patient_path(assigns(:patient)))
      expect(Patient.last.first_name).to eq("new")
    end

    it "should create_patient failed" do
      request.env["HTTP_REFERER"] = new_patient_path
      post "create", {
        patient: {
          first_name: "new",
          middle_name: "",
          last_name: "b",
          date_of_birth: "1993-02-01",
          status: "initial",
          gender: "male"
        }
      }
      expect(response).to redirect_to(new_patient_path)
      expect(Patient.count).to eql(1)
    end

    it "should show patient" do
      get "show", { id: 222 }
      expect(assigns(:patient).viewed_count).to eql(1)
    end

    it "should delete patient" do
      delete "destroy", { id: 222 }
      expect(assigns(:patient).is_deleted).to eql(true)
    end

    it "should get edit page" do
      get "edit", { id: 222 }
      expect(response).to render_template(:edit)
      expect(assigns(:patient)).to be_instance_of(Patient)
    end

    it "should update_patient success" do
      post "update", {
        id: 222,
        patient: {
          first_name: "new",
          middle_name: "",
          last_name: "b",
          status: "initial",
          gender: "male",
          location_id: 111
        }
      }
      expect(response).to redirect_to(patient_path(assigns(:patient)))
      expect(Patient.last.first_name).to eql("new")
      expect(Patient.count).to eql(1)
    end
  end
end
