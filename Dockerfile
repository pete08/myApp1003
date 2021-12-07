FROM ruby:2.6

# Allow apt to work with https-based sources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
	apt-transport-https

# Up-to-date Node
# see https://github.com/yarnpkg/yarn/issues/2888
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

# # Latest packages for Yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
# 	tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
	nodejs

# use npm to install yarn
RUN npm install --global yarn


COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

ENV BUNDLE_PATH /gems
RUN bundle install

COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]