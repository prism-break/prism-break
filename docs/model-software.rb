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

category: operating system, web browser, antivirus, etc.

TODO:
status: recommended, quarantined, rejected
# Recommended (Green) - no currently known issues
# Vulnerable (Yellow) - otherwise recommended software that contain major security vulnerabilities
# Pending (White) - suggested software that have not been reviewed.
# Declined (Black) - software that doesn't meet the quality standards of PRISM Break.
# Rejected (Red) - software with licensing issues, privacy issues, or known links to surveillance (e.g. PRISM)

licenses: GPL, MIT, BSD, etc.
localizations: english, deutsch, japanese
protocols_supported: xmpp, sip, pgp, otr
type: service, client software, server software, p2p software
platforms: web, windows, linux, osx, ios, android, bsd

# http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
# User reviews
# Five star rating and text format
# Anonymous name
# Title required
# Review must contain at least 20 words
# can link to other software

# user ranks based on # of reviews and category reviewed in
