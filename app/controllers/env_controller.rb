class EnvController < ApplicationController
  def index
    # sort by key
    render json: ENV.keys.sort.each_with_object({}){|k,d| d[k] = ENV[k]}
  end
end
