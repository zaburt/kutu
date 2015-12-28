class HomeController < ApplicationController

  def index
    @fullwidth = true
    @articles = Article.publishable.order('publish_time DESC')
  end

end

