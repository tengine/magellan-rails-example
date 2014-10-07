class HelloSubscriber < Magellan::Subscriber::Base
  before_filter :filter1
  after_filter :filter2

  def index
    Magellan.logger.info("Hello World: topic=#{topic.inspect} body=#{body.inspect}")
    Magellan.logger.info("Book.count = #{Book.count}")
  end

  def filter1
    Magellan.logger.info("== before filter!! ==")
  end
  def filter2
    Magellan.logger.info("== after filter!! ==")
  end
  private :filter1, :filter2
end
