class PagesController < ApplicationController
  def index
    @categories = Category.all
    @page_title = 'home'
  end

  def media
    @parent_path = root_path
    @page_title = 'Media Mentions'
  end

  def donate
  end
end
