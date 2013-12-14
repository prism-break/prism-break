{slugify-list} = require '../functions/sort.ls'

protocol-types = (db) ->
  types =
    * name: 'Communication'
      slug: 'communication'
      protocols: ['IRC', 'SIP', 'VoIP', 'XMPP']
    * name: 'Encryption'
      slug: 'encryption'
      protocols: ['GPG', 'OTR', 'S/MIME', 'SSL/TLS', 'ZRTP']
    * name: 'Network Anonymity'
      slug: 'network-anonymity'
      protocols: ['I2P', 'Tor']
    * name: 'Syndication'
      slug: 'syndication'
      protocols: ['RSS']
    * name: 'Collaboration'
      slug: 'collaboration'
      protocols: ['CalDAV', 'CardDAV', 'WebDAV']

  for type in types
    type.protocols = slugify-list type.protocols
  types

exports.protocol-types = protocol-types
