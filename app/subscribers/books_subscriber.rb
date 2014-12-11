require 'json'

class BooksSubscriber < Magellan::Subscriber::Base

  # /books
  def create
    book_params = JSON.parse(body)
    @book = Book.new(book_params)
    @book.save
  end

  # /books/+/update
  def update
    topic =~ /books\/(.*)\/update/
    id = $1

    book = Book.find(id)
    book_params = JSON.parse(body)
    book_params['id'] = id
    book.update(book_params)
  end

  # /books/delete
  def delete_all
    Book.delete_all
  end
end
