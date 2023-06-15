# RapidRuby.com Starter

This app is a starter template that I use for most of my example apps that I build for my Youtube and Rapid Ruby episodes.

### Core features

- Rails 7
- Hotwire using esbuild
- Tailwind CSS
- User authentication with authentication-zero
- ViewComponent
- RSpec

### Creating a fresh app

The below is customised to my workflow, you may want to skip/tweak a few of the steps. Requires `brew install gh` to create the new repository.

```sh
# Setup commands
cd ~/Sites/youtube
git clone git@github.com:phawk/rapid-ruby-starter.git new_project_name
cd new_project_name
code .
bundle install
git remote rm origin
gh repo create new_project_name --public --source=.
git push origin main -u
bin/rails db:create
# Run the server
bin/dev
```

### License

[The MIT License (MIT)](LICENSE.txt)
