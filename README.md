## Development with Docker

### Serve the site
```bash
docker compose up
```

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

3. Install the gems inside the Docker container:
   ```bash
   docker-compose run --rm jekyll bundle install
   ```

4. Restart the Jekyll server:
   ```bash
   docker-compose down
   docker-compose up
   ```

The installed gems are persisted in the `jekyll-gems` volume, so they remain available between container restarts.
