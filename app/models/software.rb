class Software < ActiveRecord::Base
  # associations
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :protocol_softwares
  has_many :protocols, through: :protocol_softwares
  has_many :license_softwares
  has_many :licenses, through: :license_softwares
  has_many :operating_system_softwares
  has_many :operating_systems, through: :operating_system_softwares

  # translations and edit history
  translates :title, :description, :url, :source_url, :privacy_url, :tos_url, :license_url, :versioning => true
  has_paper_trail
  
  # paperclip
  has_attached_file :logo,
    :styles => {
      :large_2x => "240x240",
      :large => "120x120",
      :medium_2x => "120x120",
      :medium => "60x60",
      :legacy_2x => "100x100>",
      :legacy => "50x50>",
      :small_2x => "80x80>",
      :small => "40x40>",
      :tiny_2x => "48x48>",
      :tiny => "24x24>",
    },
    :default_style => :legacy,
    :default_url => "/images/:style/missing.png",
    :convert_options => {
      :all => "-strip -alpha set"
    }

  # validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :source_url, presence: true, uniqueness: true
  validates :license_url, presence:true, uniqueness: true

  # url validation
  validates_format_of :url, :source_url, :privacy_url, :tos_url,
    :with => URI::regexp(%w(http https)),
    :message => "requires 'https://' or 'http://'",
    :allow_blank => :true

  # attachment validations
  validates_attachment :logo,
    :size => { :in => 1..50.kilobytes }
  validates_attachment_content_type :logo,
    :content_type => /^image\/(png|x-png|svg|svg+xml)$/,
    :message => 'should only be png or svg'
  validate :attachment_is_square, :unless => "errors.any?"

  # attachment deletion
  attr_accessor :delete_logo
  before_validation { logo.clear if delete_logo == '1' }

  def attachment_is_square
    dimensions = Paperclip::Geometry.from_file(logo.queued_for_write[:original].path)
    if dimensions.width != dimensions.height
      errors.add(:logo,'width and height should be equal')
    end
  end

end
