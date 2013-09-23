class Software < ActiveRecord::Base
  translates :title, :description, :url, :source_url, :privacy_url, :tos_url, :versioning => true
  has_paper_trail
end
