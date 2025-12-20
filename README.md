## Development Setup

### Prerequisites

Install Ruby and development tools:
```bash
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev
```

Configure gem installation directory (to avoid using sudo):
```bash
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Install Jekyll and Bundler:
```bash
gem install jekyll bundler
```

### Initial Setup

Install project dependencies:
```bash
bundle install
```

### Run the site

```bash
bundle exec jekyll serve --livereload --incremental --watch
```

The site will be available at `http://localhost:4000`

### Installing Jekyll Plugins

1. Add the plugin to your `Gemfile`:
   ```ruby
   group :jekyll_plugins do
     gem "plugin-name", "~> version"
   end
   ```

2. Add the plugin to `_config.yml`:
   ```yaml
   plugins:
     - plugin-name
   ```

3. Install the new gem:
   ```bash
   bundle install
   ```

4. Restart the Jekyll server (Ctrl+C and run the serve command again)
