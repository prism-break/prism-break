class Platform < ActiveRecord::Base
  translates :title, :description, :wikipedia_url, :versioning => true
end
