# [config] IMAGE_NAME: "groovenauts/magellan-rails-example"
# [config] BEFORE_BUILD:
# [config]   - rm -rf public/assets
# [config]   - bundle exec rake assets:clean assets:precompile

FROM groovenauts/ruby:2.1.2
MAINTAINER magellan@groovenauts.jp

ENV RAILS_ENV production

# for debug via HTTP dicrectly
# EXPOSE 3000

ADD . /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app/log

RUN bundle install --system

CMD ["bundle", "exec", "magellan-rails"]
