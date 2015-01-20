class HealthcheckController < ApplicationController
  def hello
    logger.info('HealthcheckController#hello')
    render json: {hello: 'world' }
  end

  def echo
    render json: {echo: params[:st]}
  end

  VERSION = File.read(Rails.root.join("VERSION").to_s).strip
  def show_version
    render json: {version: VERSION}
  end

  def show_env
    # sort by key
    render json: ENV.keys.sort.each_with_object({}){|k,d| d[k] = ENV[k]}
  end

  def get_sleep
    t = (params[:t] || 1).to_i.seconds
    sleep(t)
    render json: {sleep: t}
  end
end
