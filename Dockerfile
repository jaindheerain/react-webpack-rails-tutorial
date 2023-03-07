# TODO: Document where used
# Maybe outdated.
# Control Plane setup is in the .controlplane directory
FROM ruby:3.1.2

RUN apt-get update

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash
RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR /app
COPY Gemfile* ./

RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY . ./

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=49a95535fb050dcceb4ad15ec75eda385745a45c085c1b8e19b65e1166eb7ee97a301f9bb38e359c2e81a46ea01cddc546ba59357d18638f089b701d181ecba2

RUN rails react_on_rails:locale && rails assets:precompile

CMD ["rails", "s"]
