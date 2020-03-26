FROM ruby:2.6.4
RUN apt-get update && apt-get install apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

ENV RAILS_ROOT /oremeshi
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY . .
RUN bundle install

EXPOSE 3000

RUN mkdir -p tmp/sockets

COPY Docker/app/startup.sh /startup.sh
RUN chmod 744 /startup.sh
CMD ["/startup.sh"]

