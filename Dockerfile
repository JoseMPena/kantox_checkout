FROM ruby:3.3.1

COPY Gemfile Gemfile.lock ./
RUN bundle install

WORKDIR /app
COPY . .

ENTRYPOINT [""]