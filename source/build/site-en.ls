'use strict'

{write-localized-site} = require '../functions/build.ls'
i18n = require '../i18n/index.ls'

iso639 = 'en'
locale = i18n[iso639]

write-localized-site(iso639, locale)
