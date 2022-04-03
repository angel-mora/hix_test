FROM ruby:3.1.0
RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends \
    postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1

COPY Gemfile* /hix_test/
WORKDIR /hix_test
RUN bundle install
COPY . /hix_test

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000
EXPOSE 587

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

# Add something like `rails webpacker:install` to the entrypoint.sh script OR THE ONE WHO NEEDS TO GET IT
# maybe? `./bin/webpack-dev-server`
