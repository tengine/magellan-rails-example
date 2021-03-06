# [config] IMAGE_NAME: "groovenauts/magellan-rails-example"
# [config] BEFORE_BUILD:
# [config]   - rm -rf public/assets
# [config]   - bundle exec rake assets:clean assets:precompile

FROM ruby:2.2
MAINTAINER magellan@groovenauts.jp

ENV RAILS_ENV production

# for debug via HTTP dicrectly
# EXPOSE 3000

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
VOLUME /usr/src/app/log

ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install --system --without development test && rm /usr/local/lib/ruby/gems/2.2.0/cache/*.gem && rm /usr/local/bundle/cache/*.gem
ADD . /usr/src/app

CMD ["bundle", "exec", "magellan-rails"]
