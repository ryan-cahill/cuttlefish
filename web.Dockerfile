# Pick this to be the same as .ruby-version
FROM ruby:2.5.1

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

COPY ./ /app

CMD ["/bin/sh", "-c", "bundle exec rake db:setup && rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
