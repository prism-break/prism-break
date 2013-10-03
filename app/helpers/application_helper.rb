module ApplicationHelper

  def locales
    I18n.available_locales.sort
  end

  def languages
    locales.map do |locale|
      [I18n.t('i18n.language.name', locale: locale), locale.to_s]
    end
  end

end
