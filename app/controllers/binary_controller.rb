require 'base64'

class BinaryController < ApplicationController

  def post
    body = request.body.read
    send_data body, type: "application/octet-stream", dispatch: :inline
  end

  def info
    body = request.body.read
    size = body.bytesize
    type = request.content_type
    render json: { size: size, type: type, body: Base64.encode64(body) }
  end
end
