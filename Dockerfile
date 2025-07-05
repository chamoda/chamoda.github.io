FROM jekyll/jekyll:4.2.0

# Copy Gemfile and install dependencies
COPY Gemfile* /srv/jekyll/
RUN bundle install

# Set working directory
WORKDIR /srv/jekyll