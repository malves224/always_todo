FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app_backend

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN bundle install

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]