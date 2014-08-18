require 'rails_helper'

RSpec.describe Book, :type => :model do
  describe "title validation" do
    let(:book){Book.new}
    subject{book}

    context "titke is not empty" do

      before do
        book.title = "sample title"
      end
      it 'model is valied' do
        is_expected.to be_valid
      end
    end

    context "titke is empty" do
      before do
        book.title = ""
      end
      it 'model is invalid'do
        is_expected.to be_invalid
      end
    end
  end
end
