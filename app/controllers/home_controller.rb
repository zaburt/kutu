class HomeController < ApplicationController

  def index
    @fullwidth = true
    @articles = Article.frontpage.publishable.order('publish_time DESC')
  end

end

