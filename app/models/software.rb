class Software < ActiveRecord::Base
  # validations
  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :source_url, presence: true

  validates_format_of :url, :source_url, :privacy_url, :tos_url,
    :with => URI::regexp(%w(http https)),
    :message => "requires 'https://' or 'http://'",
    :allow_blank => :true

  # translations and edit history
  translates :title, :description, :url, :source_url, :privacy_url, :tos_url, :versioning => true
  has_paper_trail

  # associations
  has_many :categorizations
  has_many :categories, through: :categorizations
end
