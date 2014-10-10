# -*- coding: utf-8 -*-
require 'rails_helper'
require 'base64'


RSpec.describe BinaryController, :type => :request do

  let(:valid_session) { {} }

  describe "POST: /binary" do
    it "return binary response" do
      req_body = "\xff"
      post "/binary", req_body, { "CONTENT_TYPE" => "application/octet-stream" }
      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(response.body.inspect).to eq(req_body.inspect)
    end
  end

  describe "POST: /binary/info" do
    it "return binary info response" do
      req_body = "\xff"
      post "/binary/info", req_body, { "CONTENT_TYPE" => "application/octet-stream" }
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      puts body
      expect(body["size"]).to eq(1)
      expect(body["type"]).to eq("application/octet-stream")
      expect(body["body"]).to eq(Base64.encode64(req_body))
    end
  end

end
