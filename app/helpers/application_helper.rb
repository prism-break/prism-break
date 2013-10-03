module ApplicationHelper

  def languages
    [
      ['English', 'en'],
      ['Deutsch', 'de'],
      ['Nihongo', 'ja']
    ]
  end

  def locales
    I18n.available_locales.sort
  end

  def locale_name_pairs
    locales.map do |locale|
      [I18n.t('i18n.language.name', locale: locale), locale.to_s]
    end
  end

end
