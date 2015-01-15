# coding: utf-8
class MqttController < ApplicationController

  # POST: /mqtt/auth
  # MQTTの認証を行なう。
  def auth
    response.headers['X-MQTT-AUTH'] = "YES"
    auth = {
      publish_topics:   %w(hello/index worker/pub books/create books/update books/delete_all),
      subscribe_topics: %w(rooms/001 test/test)
    }
    render json: auth.to_json
  end

  # POST: /mqtt/auth2
  # MQTTの認証を行なう。
  # 認証時のボディが空
  def auth2
    response.headers['X-MQTT-AUTH'] = "YES"
    auth = {}
    render json: auth.to_json
  end

  # POST: /mqtt/auth3
  # MQTTの認証を行なう。
  # 認証時のpub/subトピックが空
  def auth3
    response.headers['X-MQTT-AUTH'] = "YES"
    auth = {
      publish_topics:   [],
      subscribe_topics: []
    }
    render json: auth.to_json
  end

end
