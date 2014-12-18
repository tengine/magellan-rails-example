require 'rails_helper'

RSpec.describe HealthcheckController, :type => :controller do

  describe "GET hello" do
    it "returns http success" do
      get :hello
      expect(response).to be_success
    end

    it 'get hello' do
      get :hello
      json = JSON.parse(response.body)
      expect(json['hello']).to eq('world')
    end
  end

  describe "GET echo" do
    it "returns http success" do
      get :echo
      expect(response).to be_success
    end

    it 'get echo' do
      get :echo, st: 'back'
      json = JSON.parse(response.body)
      expect(json['echo']).to eq('back')
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
