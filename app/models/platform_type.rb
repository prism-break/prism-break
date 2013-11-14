class PlatformType < ActiveRecord::Base
  # associations
  has_many :platforms

  # translations
  translates :title, :versioning => true

  # validations
  validates :title, presence: true, uniqueness: true
end
