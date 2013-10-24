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
      :'large@2x' =>  ["240x240>", :png],
      :large =>       ["120x120>", :png],
      :'medium@2x' => ["120x120>", :png],
      :medium =>      ["60x60>",   :png],
      :'small@2x' =>  ["80x80>",   :png],
      :small =>       ["40x40>",   :png],
      :'tiny@2x' =>   ["48x48>",   :png],
      :tiny =>        ["24x24>",   :png]
    },
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:class/:attachment/:id/:basename_:style.:extension",
    :default_url => "/images/:style/missing.png"

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
    :size => { :in => 1..100.kilobytes }
  validates_attachment_content_type :logo,
    :content_type => /^image\/(png|x-png|svg|svg\+xml)$/,
    :message => 'should only be png or svg'

  # attachment deletion
  attr_accessor :delete_logo
  before_validation { logo.clear if delete_logo == '1' }

end
