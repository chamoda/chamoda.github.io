Build with docker

`docker run --rm -it -v $(pwd):/srv/jekyll jekyll/jekyll:4.2.0 jekyll build --watch`

Serve with docker

`docker run --rm -it -v $(pwd):/srv/jekyll -p 4000:4000 -p 35729:35729 jekyll/jekyll:4.2.0 jekyll serve --incremental --livereload`