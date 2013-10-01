# remove coffeescript, sass

# rails console bugfix
gem 'rb-readline', '~> 0.4.2'

# add these template languages
gem 'slim-rails'
gem 'livescript-rails'

# handles .styl files in app/assets/stylesheets
gem 'stylus', :github => 'lucasmazza/ruby-stylus'

# for easy localized routes
gem 'routing-filter', :github => 'svenfuchs/routing-filter'

# for friendly_ids
gem 'friendly_id', :github => 'norman/friendly_id'

# for image uploads
gem 'paperclip'

# for tracking changes to the model and model translations
gem 'globalize3', github: 'svenfuchs/globalize3', branch: 'rails4'
gem 'paper_trail', github: 'airblade/paper_trail', branch: 'master'

# for tags and translated tags
# I18n guide here: http://danielpuglisi.com/articles/2013/09/setup-acts_as_taggable_on-with-globalize3
gem 'acts-as-taggable-on'

# for authentication
gem 'devise'

# for voting on software
# 5 star rating gem

# for voting system on comments
# https://github.com/ryanto/acts_as_votable
gem 'acts_as_votable'
