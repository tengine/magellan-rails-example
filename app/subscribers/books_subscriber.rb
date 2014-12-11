require 'json'

class BooksSubscriber < Magellan::Subscriber::Base

  # /books
  def create
    book_params = JSON.parse(body)
    @book = Book.new(book_params)
    @book.save
  end

end
