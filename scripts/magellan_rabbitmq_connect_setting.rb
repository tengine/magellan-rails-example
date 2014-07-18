# -*- coding: utf-8 -*-
require 'rabbitmq/http/client'
require 'redis'
require 'json'


if ARGV.size < 4
  puts 'please set 4 arguments'
  puts 'arg1 title name'
  puts 'arg2 title runtime ver'
  puts 'arg3 RubyWorker: worker name, RailsWorker: \'rails\''
  puts 'arg4 name of transaction-router on RabbitMQ'
  puts 'arg5 password of transaction-router on RabbitMQ'
  puts 'arg6 password of worker on RabbitMQ'
  exit(1)
end

# 第1引数: タイトル名
# 第2引数: タイトルランタイムバージョン
# 第3引数: ワーカー名, Railsワーカーの場合は rails
# 第4引数: magellan-transaction-routerがRabbitMQへ接続する際のユーザー名
# 第5引数: magellan-transaction-routerがRabbitMQへ接続する際のパスワード
# 第6引数: ワーカー(magellan-worker-ruby, magellan-rails)がRabbitMQへ接続する際の、タイトル毎に固有のパスワード
# 例 : ruby magellan_rabbitmq_connect_setting.rb customer1.magellan-rails-example 0.0.1 rails transaction-router pswd1 pswd2
title_name        = ARGV[0]  # 例: 'example'customer1.sample_project'
title_runtime_ver = ARGV[1]  # 例: '1.0.0'
worker_name       = ARGV[2]  # 例: 'SampleLogicA' or 'rails'
tr_name           = ARGV[3]  # 例: 'transaction-router'
tr_password       = ARGV[4]  # 例: 'pswd1'
title_password    = ARGV[5]  # 例: 'pswd2'

request_queue_name  = "#{title_name}.#{title_runtime_ver}.#{worker_name}"
routing_key         = "#{title_runtime_ver}.rails"

redis_host          = ENV['REDIS_PORT_6379_TCP_ADDR']     # || "127.0.0.1"
redis_port          = ENV['REDIS_PORT_6379_TCP_PORT']     # || 6379
rabbitmq_host       = ENV['RABBITMQ_PORT_15672_TCP_ADDR'] # || '127.0.0.1'
rabbitmq_port       = ENV['RABBITMQ_PORT_15672_TCP_PORT'] # || '15672'
admin_user          = ENV['RABBITMQ_ENV_RABBITMQ_USER']   # || 'guest'
admin_pass          = ENV['RABBITMQ_ENV_RABBITMQ_PASS']   # || 'guest'

# RabbitMQに接続
endpoint = "http://127.0.0.1:15672"
client = RabbitMQ::HTTP::Client.new(endpoint, :username => admin_user, :password => admin_pass)

# タイトルに1:1で対応させるユーザの作成
client.update_user(title_name, tags: '', password: title_password)

# magellan-transaction-router用のユーザの作成
client.update_user(tr_name, tags: '', password: tr_password)

# タイトルに1:1で対応させるバーチャルホストの作成
client.create_vhost("/#{title_name}")

# 管理ユーザが上記で作成したバーチャルホストにエクスチェンジやキューを作成できるようにするために
# 管理ユーザに上記で作成したバーチャルホストに関するフルアクセス権限を付与
admin_ps = client.user_permissions(admin_user)
# Update permissions of a user in a vhost
admin_ps = client.update_permissions_of("/#{title_name}", admin_user, :write => ".*", :read => ".*", :configure => ".*")

# magellan-transaction-routerが使用するユーザに、 magellan-transaction-routerが動作するのに必要最低限の権限を付与
# 暫定的に全権限を付与
tr_ps = client.user_permissions(tr_name)
# Update permissions of a user in a vhost
tr_ps = client.update_permissions_of("/#{title_name}", tr_name, :write => ".*", :read => ".*", :configure => ".*")

# ワーカー使用するユーザに、ワーカーが動作するのに必要最低限の権限を付与
title_ps = client.user_permissions(title_name)
# Update permissions of a user in a vhost
title_ps = client.update_permissions_of("/#{title_name}", title_name, :write => ".*", :read => ".*", :configure => "")

# ワーカー処理要求用, ワーカ処理結果返却用エクスチェンジの作成
#                        vhost,            name,                 attributes = {}
client.declare_exchange("/#{title_name}", "#{title_name}.request", type: 'direct', auto_delete: false, durable: false)
client.declare_exchange("/#{title_name}", "#{title_name}.reply"  , type: 'direct', auto_delete: false, durable: false)

# ワーカー処理要求用キューの作成
client.declare_queue("/#{title_name}", request_queue_name, :durable => false, :auto_delete => false)

# ワーカー処理要求用エクスチェンジとキューをバインド
client.bind_queue("/#{title_name}", request_queue_name, "#{title_name}.request", routing_key)

####################################################################
# 以下は第1回インテグレーションテスト時のためだけの暫定対応
# 本来は名前が可変のワーカ処理結果返却用キューを決め打ちで作成して
# Redisの キー :title/reply_queues にワーカーの処理結果を返すキューのリストを登録します

# ワーカー処理要求用キューの作成
client.declare_queue("/#{title_name}", "#{title_name}.reply.001", :durable => false, :auto_delete => false)

# ワーカー処理要求用エクスチェンジとキューをバインド
client.bind_queue("/#{title_name}", "#{title_name}.reply.001", "#{title_name}.reply", '001')

r = Redis.new(host: redis_host, port: redis_port)

# このスクリプトを実行する度にRedisに同一の 'ワーカーの処理結果を返すキュー' の設定が追加されてしまうため
# Redisから該当キーを削除してから設定処理を行います
r.del 'customer1.magellan-rails-example.reply_queues'

# ワーカーの処理結果を返すキューの設定をセット
reply_queue_config = {queue:  "#{title_name}.reply.001", routing_key:"001"}.to_json

r.lpush("#{title_name}.reply_queues" , reply_queue_config)
r.quit

puts "complete success!"
