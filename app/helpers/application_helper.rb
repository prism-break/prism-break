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

end
