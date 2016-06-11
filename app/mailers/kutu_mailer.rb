class KutuMailer < ActionMailer::Base
  layout 'mail'
  helper ApplicationHelper

  default :from => 'bilgi@fakatiyioynadik.com',
    :to => Proc.new { User.pluck(:email) },
    'List-Id' => 'kutu_notification'

  def article_new(article)
    @article = article
    mail(:subject => I18n.t('notification.article_new'))
  end

  def game_comment_new(game_comment)
    @game_comment = game_comment
    mail(:subject => I18n.t('notification.game_comment_new'))
  end

  def game_new(game)
    @game = game
    mail(:subject => I18n.t('notification.game_new'))
  end

end
