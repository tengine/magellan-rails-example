class HelloSubscriber < Magellan::Subscriber::Base
  before_filter :filter1
  after_filter :filter2

  def index
    logger.info("Hello World: topic=#{topic.inspect} body=#{body.inspect}")
    logger.info("Book.count = #{Book.count}")
  end

  def filter1
    logger.info("== before filter!! ==")
  end
  def filter2
    logger.info("== after filter!! ==")
  end
  private :filter1, :filter2
end
