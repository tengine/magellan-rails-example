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
  describe "PUBLISH worker/books" do
    it "works! (now write some real specs)" do
      publish "worker/books", {"title" => "sample book"}.to_json
      expect(Book.count).to eq 1
      expect(Book.first.title).to eq 'sample book'
    end
  end

  describe "PUBLISH worker/books/1/update" do
    before do
      Book.new({id: 1, title: 'sample book ver1'}).save
    end

    it "works! (now write some real specs)" do
      publish "worker/books/1/update", {"title" => "sample book ver2"}.to_json
      expect(Book.count).to eq 1
      expect(Book.first.title).to eq 'sample book ver2'
    end
  end

  describe "PUBLISH worker/books/delete" do
    before do
      Book.new({title: 'sample book1'}).save
      Book.new({title: 'sample book2'}).save
    end

    it "works! (now write some real specs)" do
      publish "worker/books/delete", ''
      expect(Book.count).to eq 0
    end
  end
end
