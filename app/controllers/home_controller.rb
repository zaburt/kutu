class HomeController < ApplicationController

  def index
    @articles = Article.publishable.order('publish_time DESC')
  end

end

