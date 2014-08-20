# [config] IMAGE_NAME: "groovenauts/magellan-rails-example"
# [config] BEFORE_BUILD:
# [config]   - rm -rf public/assets
# [config]   - bundle exec rake assets:clean assets:precompile
#
# 0. イメージ作り直し
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -a | awk '/^<none>/{print $3}')
#
# 1. イメージバージョンを更新
# brocket version bump
# or
# brocket version minor
#
# 1. イメージ作成時
# brocket release
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
# 6. HTTPでデバッグ実行
# docker run --link redis:redis --link rabbitmq:rabbitmq -v /var/log/app:/usr/src/app/log:rw -e SECRET_KEY_BASE=$SECRET_KEY_BASE -p 3000:3000 -d -t groovenauts/magellan-rails-example bundle exec rails server
#
#   A. boot2dockerを使っている場合
#     1. boot2docker ip の出力からIPを確認
#     2. boot2docker info で"Docker Port"を確認
#     3. ブラウザで hhtp://#{1のIP}:#{2のポート} を開く
#

FROM groovenauts/ruby:2.1.2
MAINTAINER magellan@groovenauts.jp

ENV RAILS_ENV production

# for debug via HTTP dicrectly
# EXPOSE 3000

ADD . /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app/log

RUN bundle install --system

RUN gem install rabbitmq_http_api_client redis json

CMD ["bundle", "exec", "magellan-rails"]
