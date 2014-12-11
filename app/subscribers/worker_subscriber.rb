class WorkerSubscriber < Magellan::Subscriber::Base

  def pub
    logger.info("WorkerSubscriber#pub_test")
    Magellan::Publisher.publish("rooms/0001", "#{body} from Worker.")
  end

end
