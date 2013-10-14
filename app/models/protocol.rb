class Protocol < ActiveRecord::Base
  # localization
  translates :title, :description, :url, :versioning => true
  has_paper_trail

  # validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
end
