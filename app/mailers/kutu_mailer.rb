class KutuMailer < ActionMailer::Base
  layout 'mail'
  helper ApplicationHelper

  default :from => 'bilgi@fakatiyioynadik.com',
    :to => Proc.new { User.pluck(:email) }

  def new_article(article)
    @article = article
    mail(:subject => I18n.t('notification.new_article'))
  end

  def new_game_comment(game_comment)
    @game_comment = game_comment
    mail(:subject => I18n.t('notification.new_game_comment'))
  end

  def new_game(game)
    @game = game
    mail(:subject => I18n.t('notification.new_game'))
  end

end
