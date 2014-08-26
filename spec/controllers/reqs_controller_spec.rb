require 'rails_helper'

RSpec.describe ReqsController, :type => :request do

  let(:valid_session) { {} }

  describe "GET: /reqs" do
    it "return JSON response" do
      get "/reqs?test=test"
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body["path"]).to eq("/reqs")
      expect(body["method"]).to eq("GET")
      expect(body["query"]).to eq("test=test")
      expect(body["body"]).to eq("")
    end
  end

  describe "GET: /reqs/test" do
    it "return JSON response" do
      get "/reqs/test?test=test"
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body["path"]).to eq("/reqs/test")
      expect(body["method"]).to eq("GET")
      expect(body["query"]).to eq("test=test")
      expect(body["body"]).to eq("")
    end
  end

  describe "POST: /reqs" do
    it "return JSON response" do
      req_body = {test1: "test1", test2: "test2"}.to_json
      post "/reqs?test=test", req_body
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body["path"]).to eq("/reqs")
      expect(body["method"]).to eq("POST")
      expect(body["query"]).to eq("test=test")
      expect(body["body"]).to eq(req_body)
    end
  end

  describe "PUT: /reqs/test" do
    it "return JSON response" do
      req_body = {test1: "test1", test2: "test2"}.to_json
      put "/reqs/test?test=test", req_body
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body["path"]).to eq("/reqs/test")
      expect(body["method"]).to eq("PUT")
      expect(body["query"]).to eq("test=test")
      expect(body["body"]).to eq(req_body)
    end
  end

  describe "DELETE: /reqs/test" do
    it "return JSON response" do
      delete "/reqs/test?test=test"
      expect(response).to be_success
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body["path"]).to eq("/reqs/test")
      expect(body["method"]).to eq("DELETE")
      expect(body["query"]).to eq("test=test")
      expect(body["body"]).to eq("")
    end
  end

end
