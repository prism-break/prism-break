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
  
  # paperclip
  has_attached_file :logo,
    :styles => {
      :large_2x => "1024x1024",
      :large => "512x512",
      :medium_2x => "120x120>",
      :medium => "60x60>",
      :small_2x => "80x80>",
      :small => "40x40>"
    },
    :default_url => "/images/:style/missing.png"
end
