FROM ruby:3.1.2

RUN curl https://deb.nodesource.com/setup_19.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

WORKDIR /usr/src/app

COPY . .
RUN bundle install
