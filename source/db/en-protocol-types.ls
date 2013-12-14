{slugify-list} = require '../functions/sort.ls'

protocol-types = (db) ->
  types =
    * name: 'Communication'
      slug: 'communication'
      categories: ['IRC', 'SIP', 'VoIP', 'XMPP']
    * name: 'Encryption'
      slug: 'encryption'
      categories: ['GPG', 'OTR', 'S/MIME', 'SSL/TLS', 'ZRTP']
    * name: 'Network Anonymity'
      slug: 'network-anonymity'
      categories: ['I2P', 'Tor']
    * name: 'Synchronization'
      slug: 'synchronization'
      categories: ['CalDAV', 'CardDAV', 'RSS', 'WebDAV']

  for type in types
    type.categories = slugify-list type.categories
  types

exports.protocol-types = protocol-types
