# coding: utf-8
class MqttController < ApplicationController

  # POST: /mqtt/auth
  # MQTTの認証を行なう。
  def auth
    response.headers['X-MQTT-AUTH'] = "YES"
    render json: {auth: true}
  end

end
