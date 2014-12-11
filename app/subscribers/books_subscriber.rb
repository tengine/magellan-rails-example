require 'json'

class BooksSubscriber < Magellan::Subscriber::Base

  def create
    book_params = JSON.parse(body)
    @book = Book.new(book_params)
    @book.save
  end

end
