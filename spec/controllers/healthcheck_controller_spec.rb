require 'rails_helper'

RSpec.describe HealthcheckController, :type => :controller do

  describe "GET hello" do
    it "returns http success" do
      get :hello
      expect(response).to be_success
    end
  end

  describe "GET echo" do
    it "returns http success" do
      get :echo
      expect(response).to be_success
    end
  end

  describe "GET version" do
    it "returns http success" do
      get :show_version
      expect(response).to be_success
    end
  end

  describe "GET env" do
    it "returns http success" do
      get :show_env
      expect(response).to be_success
    end
  end

end
