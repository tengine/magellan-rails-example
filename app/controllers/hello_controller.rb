class HelloController < ApplicationController
  def index
    render json: {hello: 'world' }
  end

  def echo
    render json: {echo: params[:st]}
  end
end
