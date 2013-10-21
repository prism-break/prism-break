class PagesController < ApplicationController
  def index
    @categories = Category.all
    @page_title = 'home'
  end

  def media
  end

  def donate
  end
end
