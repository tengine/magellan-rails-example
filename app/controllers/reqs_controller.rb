require 'base64'

class ReqsController < ApplicationController

  respond_to :json

  # GET: /reqs
  def index
    show_data()
  end

  # GET: /reqs:id
  def show
    show_data()
  end

  # POST: /reqs
  def create
    show_data()
  end

  # PUT: /reqs/:id
  def update
    show_data()
  end

  # DELETE: /reqs/:id
  def destroy
    show_data()
  end


  private

  def show_data
    r = request
    body = r.body.read
    begin
      {body: body}.to_json
    rescue Encoding::UndefinedConversionError
      body = Base64.strict_encode64(body)
    end
    dat = {
      method: r.request_method,
      path: r.path_info,
      query: r.query_string,
      body: body,
      params: params
    }
    render :json => dat
  end
end
