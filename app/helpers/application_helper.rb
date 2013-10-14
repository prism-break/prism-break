module ApplicationHelper

  def accepted_locales
    I18n.available_locales.sort
  end

  def languages
    accepted_locales.map do |locale|
      [I18n.t('i18n.language.name', locale: locale), locale.to_s]
    end
  end

  def filter_markdown(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

end
