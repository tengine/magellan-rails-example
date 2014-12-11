require 'rails_helper'

RSpec.describe "Books", :type => :request do
  describe "GET /books" do
    it "works! (now write some real specs)" do
      get books_path
      expect(response.status).to be(200)
    end
  end
end

describe "BooksSubscriber", :type => :request do
  describe "PUBLISH /books" do
    it "works! (now write some real specs)" do
      publish "books", {"title" => "sample book"}.to_json
      expect(Book.count).to eq 1
      expect(Book.first.title).to eq 'sample book'
    end
  end
end
