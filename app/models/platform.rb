class Platform < ActiveRecord::Base
  # associations
  has_many :categories

  translates :title, :description, :wikipedia_url, :versioning => true

  # validations
  validates :title, presence: true, uniqueness: true

  # url validation
  validates_format_of :wikipedia_url,
    :with => URI::regexp(%w(http https)),
    :message => "requires 'https://' or 'http://'",
    :allow_blank => :true

end
