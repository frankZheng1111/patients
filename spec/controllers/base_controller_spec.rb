require 'rails_helper'

RSpec.describe BaseController, type: :controller do
  it "should set language" do
    post "change_locale", { locale: "zh-CN"}
    expect(response).to redirect_to(root_path)
    expect(session[:locale]).to eql("zh-CN")
  end
end
