FROM ruby:3.0.1

ENV APP_PATH /app
ENV BUNDLE_VERSION 2.1.4
# ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# copy entrypoint scripts and grant execution permissions
COPY ./dev-docker-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
COPY ./test-docker-entrypoint.sh /usr/local/bin/test-entrypoint.sh
RUN chmod +x /usr/local/bin/dev-entrypoint.sh && chmod +x /usr/local/bin/test-entrypoint.sh

RUN chmod 777 /usr/local/bin/dev-entrypoint.sh && ln -s /usr/local/bin/dev-entrypoint.sh /

# RUN apk update
# 
# # install dependencies for application
# RUN apk -U add --no-cache \
# build-base \
# git \
# postgresql-dev \
# postgresql-client \
# libxml2-dev \
# libxslt-dev \
# nodejs \
# yarn \
# imagemagick \
# tzdata \
# less \
# && rm -rf /var/cache/apk/* \
# && mkdir -p $APP_PATH 

RUN apt-get update -qq

# install dependencies for application
RUN apt-get install -y \
git \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
imagemagick \
tzdata \
less \
&& rm -rf /var/cache/apk/* \
&& mkdir -p $APP_PATH 

# RUN gem install bundler --version "$BUNDLE_VERSION" \
# && rm -rf $GEM_HOME/cache/*

RUN gem install bundler --version "$BUNDLE_VERSION"

# navigate to app directory
WORKDIR $APP_PATH

EXPOSE $RAILS_PORT

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN bundle install -j 20

# ENTRYPOINT ["bash","entrypoint.prod.sh"]

ENTRYPOINT [ "bundle", "exec" ]

COPY . .
