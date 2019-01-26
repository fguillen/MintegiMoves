FROM ruby:2.5.1

# Install dependencies
RUN apt-get update && apt-get -y install cron

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV="production"
ENV RACK_ENV="production"
ENV SECRET_KEY_BASE="87042df8b0b5889cb81d8452a218251f7940d2854fde79a3c9b4108dd1e9875227a868bb122bc23c833432ca37b3fe7b7c51453a0c9285661e5b2ce8a5a53453"

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test

# Adding project files
COPY . .
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

## Cron config

# Add crontab file to the cron.d directory
COPY crontab /etc/cron.d/app

# Give execution rights on the cron job
# Files in /etc/cron.d can not have names with "-" or ".". It can be problematic
RUN chmod 0644 /etc/cron.d/app

# To load the env variables in cron sessions
# without this the user in the cron session won't be able to find commands and Gems
RUN printenv | grep -v "no_proxy" >> /etc/environment

# Run the command on container startup
CMD ["cron", "-f"]
