class Software < ActiveRecord::Base
  validates :title, presence: true

  has_many :comments

  belongs_to :developer
end

title: string
description: text
developer: string
logo: image

# Links

url: string
source_url: string
privacy_url: string
tos_url: string

# Tag groups

status: recommended, quarantined, rejected
category: operating system, web browser, antivirus, etc.
type: service, client software, server software, p2p software
licenses: GPL, MIT, BSD, etc.
platforms: web, windows, linux, osx, ios, android, bsd
localizations: english, deutsch, japanese
protocols supported: xmpp, sip, pgp, otr

# http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
# User reviews
# Five star rating and text format
# Anonymous name
# Title required
# Review must contain at least 20 words
# can link to other software

# user ranks based on # of reviews and category reviewed in
