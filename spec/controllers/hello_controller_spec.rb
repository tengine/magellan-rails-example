require 'rails_helper'

RSpec.describe HelloController, :type => :controller do

  describe "GET 'index'" do
    it '200 OK' do
      get 'index'
      expect(response).to be_success
      expect(response).to be_success
    end

    it 'get hello' do
      get 'index'
      json = JSON.parse(response.body)
      expect(json['hello']).to eq('world')
    end

    it 'get echo' do
      get 'echo', st: 'back'
      json = JSON.parse(response.body)
      expect(json['echo']).to eq('back')
    end
  end

end
