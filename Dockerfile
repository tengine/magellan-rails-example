#
# 0. イメージ作り直し
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -a | awk '/^<none>/{print $3}')
#
# 1. イメージ作成時
# rm -rf public/assets && bundle exec rake assets:clean assets:precompile && docker build -t="groovenauts/magellan-rails-example" .
#
# 2. redisサーバ起動
# docker run --name redis -d redis
#
# 3. rabbitmqサーバ起動
# docker run -d --name rabbitmq  -p 5672:5672 -p 15672:15672 -e RABBITMQ_PASS="mypass" tutum/rabbitmq
#
# 4. 環境変数
# export SECRET_KEY_BASE="67a1f3d844483f15e48f7607c6c7ef17785904470198d311bfdbd39d9f8b5997620a995a667d061539cafdeb48d1838a51f1d6ceb0e96e92b1e48b36f71afd97"
#
# 5. 実行
# docker run --link redis:redis --link rabbitmq:rabbitmq -v /var/log/app:/usr/src/app/log:rw -e SECRET_KEY_BASE=$SECRET_KEY_BASE -d -t groovenauts/magellan-rails-example bundle exec magellan server
#
# 5'. HTTPでデバッグ実行
# docker run --link redis:redis --link rabbitmq:rabbitmq -v /var/log/app:/usr/src/app/log:rw -e SECRET_KEY_BASE=$SECRET_KEY_BASE -p 3000:3000 -d -t groovenauts/magellan-rails-example bundle exec rails server
#
# 6. 確認
# 6-1. boot2dockerを使っている場合
#     1. boot2docker ip の出力からIPを確認
#     2. boot2docker info で"Docker Port"を確認
#     3. ブラウザで hhtp://#{1のIP}:#{2のポート} を開く
#

FROM ruby
MAINTAINER magellan@groovenauts.jp

ENV RAILS_ENV production

# for debug via HTTP dicrectly
# EXPOSE 3000

VOLUME /usr/src/app/log
WORKDIR /usr/src/app
