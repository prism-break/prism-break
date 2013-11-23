class Software < ActiveRecord::Base
  # associations
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :protocol_softwares
  has_many :protocols, through: :protocol_softwares

  # translations and edit history
  translates :title, :description, :url, :source_url, :privacy_url, :tos_url, :license_url, :wikipedia_url, :notes, :versioning => true
  has_paper_trail
  
  # paperclip
  has_attached_file :logo,
    :styles => {
      #:'huge@2x'   => ["1024x1024>", :png],
      #:'huge'      => ["512x512>",   :png],
      #:'large@2x'  => ["480x480>",   :png],
      #:'large'     => ["240x240>",   :png],
      :'medium@2x' => ["120x120>",   :png],
      :'medium'    => ["60x60>",     :png],
      #:'small@2x'  => ["80x80>",     :png],
      #:'small'     => ["40x40>",     :png],
      #:'tiny@2x'   => ["48x48>",     :png],
      #:'tiny'      => ["24x24>",     :png]
    },
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:class/:attachment/:id/:basename_:style.:extension",
    :default_url => "/images/:style/missing.png",
    :convert_options => {
      :'huge@2x'   => "-background none -gravity center -extent 1024x1024",
      :'huge'      => "-background none -gravity center -extent 512x512",
      :'large@2x'  => "-background none -gravity center -extent 480x480",
      :'largex'    => "-background none -gravity center -extent 240x240",
      :'medium@2x' => "-background none -gravity center -extent 120x120",
      :'medium'    => "-background none -gravity center -extent 60x60",
      :'small@2x'  => "-background none -gravity center -extent 80x80",
      :'small'     => "-background none -gravity center -extent 40x40",
      :'tiny@2x'   => "-background none -gravity center -extent 48x48",
      :'tiny'      => "-background none -gravity center -extent 24x24",
    },
    processors: [:thumbnail, :compression]

  # validations
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

  # url validation
  validates_format_of :url,
    :source_url, :privacy_url, :tos_url, :wikipedia_url,
    :with => URI::regexp(%w(http https ftp)),
    :message => "requires 'https://', 'http://', or 'ftp://'",
    :allow_blank => :true

  # attachment validations
  validates_attachment :logo,
    :size => { :in => 1..2048.kilobytes }
  validates_attachment_content_type :logo,
    :content_type => /^image\/(png|x-png)$/,
    :message => 'should only be png'

  # attachment deletion
  attr_accessor :delete_logo
  before_validation { logo.clear if delete_logo == '1' }

  # wikipedia
  def has_wikipedia_page
    without_wikipedia_page = [22, 25, 45]
    unless without_wikipedia_page.include?(self.id) or self.wikipedia_url == ""
      true
    end
  end

  def wikipedia_description
    sentences = 3
    url_array = self.wikipedia_url.split('/')
    url_locale = url_array[2].split('.').first
    url_remainder = url_array.drop(4)
    page_title = url_remainder.join('/')

    extract_url = "https://#{url_locale}.wikipedia.org/w/api.php?" +
      "action=query&prop=extracts&exintro=&exsentences=#{sentences}" +
      "&explaintext=&format=xml&titles=#{page_title}"

    parse = Nokogiri::XML(open(extract_url)).xpath("//extract")
    parse.first.content
  end

  def update_description
    if self.has_wikipedia_page
      self.description = self.wikipedia_description
      self.save!
    end
  end

  def self.update_descriptions
    Software.all.each { |s| s.update_description }
  end

end
