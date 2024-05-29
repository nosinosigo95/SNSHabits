FROM ruby:3.1.5

RUN apt-get update -qq
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
&& apt-get install -y nodejs
RUN npm install -global yarn

WORKDIR /docker_rails

COPY Gemfile Gemfile.lock /docker_rails/

RUN bundle install

ADD . /docker_rails
