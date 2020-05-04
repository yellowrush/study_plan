FROM ruby:2.3.1

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    debian-keyring debian-archive-keyring \
    postgresql-client \
    nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists


# install gems with native extendsions nokogiri
RUN gem install nokogiri -v "1.10.8"

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD rails server -b 0.0.0.0