require 'rails_helper'

describe "HelloSubscriber", :type => :request do
  describe "PUBLISH /hello/index" do
    before do
      expect(Book).to receive(:count).once.and_return(1)
    end
    it "works! (now write some real specs)" do
      publish "hello/index"
    end
  end
end
