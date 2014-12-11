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
    before do
      book_double = double('book')
      expect(Book).to receive(:new).with({"title" => "sample book"}).once.and_return(book_double)
      expect(book_double).to receive(:save).once
    end
    it "works! (now write some real specs)" do
      publish "books", {"title" => "sample book"}.to_json
    end
  end
end
