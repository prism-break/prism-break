class Protocol < ActiveRecord::Base
  # associations
  has_many :protocol_softwares
  has_many :softwares, through: :protocol_softwares

  # localization
  translates :title, :description, :url, :versioning => true
  has_paper_trail

  # validations
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates_format_of :url,
    :with => URI::regexp(%w(http https)),
    :message => "requires 'https://' or 'http://'",
    :allow_blank => :true

  # wikipedia
  def has_wikipedia_page
    without_wikipedia_page = [22, 25, 45]
    unless without_wikipedia_page.include?(self.id) or self.url == ""
      true
    end
  end

  def wikipedia_description
    sentences = 3
    url_array = self.url.split('/')
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
    Protocol.all.each { |s| s.update_description }
  end

end
