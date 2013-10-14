class Protocol < ActiveRecord::Base
  translates :title, :description, :url, :versioning => true
  has_paper_trail
end
