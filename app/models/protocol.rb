class Protocol < ActiveRecord::Base
  # associations
  has_many :protocol_softwares
  has_many :softwares, through: :protocol_softwares

  # localization
  translates :title, :description, :url, :versioning => true
  has_paper_trail

  # validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates_format_of :url,
    :with => URI::regexp(%w(http https)),
    :message => "requires 'https://' or 'http://'",
    :allow_blank => :true

end
