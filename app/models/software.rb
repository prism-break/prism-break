class Software < ActiveRecord::Base
  # validations
  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :source_url, presence: true

  # translations and edit history
  translates :title, :description, :url, :source_url, :privacy_url, :tos_url, :versioning => true
  has_paper_trail

  # associations
  has_many :categorizations
  has_many :categories, through: :categorizations
end
