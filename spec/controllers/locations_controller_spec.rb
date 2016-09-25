require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  it "should get show success" do
    create(:location)
    get 'show',{ id: 111 }
    expect(response).to render_template(:show)
  end

  it "should get show failed" do
    expect{ get 'show', { id: 111 } }.to raise_error(UncaughtThrowError)
  end
end
