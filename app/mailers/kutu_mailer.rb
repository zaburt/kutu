class KutuMailer < ActionMailer::Base
  layout 'mail'
  helper ApplicationHelper

  default :from => 'bilgi@fakatiyioynadik.com',
    :to => Proc.new { User.pluck(:email) },
    'List-Id' => 'kutu_notification'

  def article_new(article)
    @article = article
    mail(:subject => I18n.t('notification.article_new', :name => article.title))
  end

  def article_destroy(article)
    @article = article
    mail(:subject => I18n.t('notification.article_destroy', :name => article.title))
  end

  def article_update(article)
    @article = article
    mail(:subject => I18n.t('notification.article_update', :name => article.title))
  end

  def game_comment_new(game_comment)
    @game_comment = game_comment
    mail(:subject => I18n.t('notification.game_comment_new', :name => game_comment.game.name))
  end

  def game_comment_destroy(game_comment)
    @game_comment = game_comment
    mail(:subject => I18n.t('notification.game_comment_destroy', :name => game_comment.game.name))
  end

  def game_comment_update(game_comment)
    @game_comment = game_comment
    mail(:subject => I18n.t('notification.game_comment_update', :name => game_comment.game.name))
  end

  def game_new(game)
    @game = game
    mail(:subject => I18n.t('notification.game_new', :name => game.name))
  end

  def game_destroy(game)
    @game = game
    mail(:subject => I18n.t('notification.game_destroy', :name => game.name))
  end

  def game_update(game)
    @game = game
    mail(:subject => I18n.t('notification.game_update', :name => game.name))
  end

end
