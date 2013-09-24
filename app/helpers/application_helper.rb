module ApplicationHelper
  def language_select_tag(name = 'set_locale')
    languages = {
      'English' => 'en',
      'Deutsch' => 'de',
      'Japanese' => 'ja'
    }
    options = options_for_select(languages, I18n.locale.to_s)
    select_tag(name, options, :onchange => 'this.form.submit()')
  end
end
