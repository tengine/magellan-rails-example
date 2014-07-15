# -*- coding: utf-8 -*-
require 'spec_helper'

describe HelloController do
  describe '#index' do
    before do
      get "/hello/index"
    end
    it '200 OK' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'get hello' do
      json = JSON.parse(response.body)
      expect(json['hello']).to eq('world')
    end
  end
end
