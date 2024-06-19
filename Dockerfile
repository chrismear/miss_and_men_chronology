FROM ruby:3.3.3-slim

LABEL Name=missandmenchronology Version=0.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# install GraphViz
RUN apt-get update -qq && apt-get install -y build-essential graphviz

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["ruby", "miss_and_men_chronology.rb"]

