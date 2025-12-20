.PHONY: run build clean install

# Run the Jekyll dev server with live reload
run:
	bundle exec jekyll serve --livereload --incremental --watch

# Build the site
build:
	bundle exec jekyll build

# Clean generated files
clean:
	rm -rf _site .jekyll-cache

# Install dependencies
install:
	bundle install
