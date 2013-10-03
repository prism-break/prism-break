module ApplicationHelper

  def accepted_locales
    I18n.available_locales.sort
  end

  def languages
    accepted_locales.map do |locale|
      [I18n.t('i18n.language.name', locale: locale), locale.to_s]
    end
  end

end
