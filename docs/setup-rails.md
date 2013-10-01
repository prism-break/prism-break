# Essential libraries for Debian 7.0
    sudo apt-get install zlib1g zlib1g-dev build-essential sqlite3 libsqlite3-dev openssl libssl-dev libyaml-dev libreadline-dev libxml2-dev libxslt1-dev

# Install rbenv and ruby 2.0
    curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
    rbenv install 2.0.0-p247 && rbenv global 2.0.0-p247

# Ruby gems
    vi ~/.gemrc
    install: --no-rdoc --no-ri
    update:  --no-rdoc --no-ri
    gem install rails

# MySQL & Rails
    sudo apt-get install libmysqlclient-dev
    export RAILS_DEFAULT_DATABASE=mysql

# New MySQL DB
    mysql -u adminusername -p
    mysql> CREATE DATABASE dbname CHARACTER SET utf8 COLLATE utf8_general_ci;
    mysql> GRANT ALL PRIVILEGES ON databasename.* TO "user"@"hostname" IDENTIFIED BY "password";
    mysql> FLUSH PRIVILEGES;
    mysql> EXIT

# Phusion Passenger
    gem install passenger
    sudo passenger-install-apache2-module

# fix Passenger errors:

## sudo: passenger-install-apache2-module: command not found
    which passenger-install-apache2-module
    sudo /home/zetheros/.rbenv/BLAH/BLAH/passenger-install-apache2-module

## No route matches [GET] "/":
Make sure to set a real index page not and then restart apache.

# 404 static assets?
    # in production.rb:
    config.serve_static_assets = true
    config.assets.compile = true

# Rails production db:migrate
    rake db:migrate RAILS_ENV=production

# Rails console error with readline not found:
    gem 'rb-readline', '~> 0.4.2'
    bundle install

# Gemfile
    gem 'slim-rails'
    gem 'stylus'

# <select> another model
    = f.collection_select :brand_id, Brand.order(:name),:id,:name, include_blank: true
