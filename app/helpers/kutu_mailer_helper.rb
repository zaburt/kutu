module KutuMailerHelper

  def humanize_game_comment_update(key, value)
    case key
    when 'game_id'
      label = t('activerecord.attributes.game_comment.game')
      old_id = @game_comment.game_id_was
      old_value = Game.find(old_id).name if old_id
      new_value = @game_comment.game.try(:name)
    when 'user_id'
      label = t('activerecord.attributes.game_comment.user')
      old_id = @game_comment.user_id_was
      old_value = User.find(old_id).display_name if old_id
      new_value = @game_comment.user.try(:display_name)
    else
      label = t("activerecord.attributes.game_comment.#{key}")
      old_value = value[0]
      new_value = value[1]
    end

    [label, old_value, new_value]
  end

  def humanize_game_update(key, value)
    case key
    when 'city_id'
      label = t('activerecord.attributes.game.city')
      old_id = @game.city_id_was
      old_value = City.find(old_id).name if old_id
      new_value = @game.city.try(:name)
    when 'house_id'
      label = t('activerecord.attributes.game.house')
      old_id = @game.house_id_was
      old_value = House.find(old_id).name if old_id
      new_value = @game.house.try(:name)
    when 'game_category_id'
      label = t('activerecord.attributes.game.game_category')
      old_id = @game.game_category_id_was
      old_value = GameCategory.find(old_id).name if old_id
      new_value = @game.game_category.try(:name)
    else
      label = t("activerecord.attributes.game.#{key}")
      old_value = value[0]
      new_value = value[1]
    end

    [label, old_value, new_value]
  end

  def humanize_article_update(key, value)
    case key
    when 'game_id'
      label = t('activerecord.attributes.article.game')
      old_id = @article.game_id_was
      old_value = Game.find(old_id).name if old_id
      new_value = @article.game.try(:name)
    when 'updated_by_id'
      label = t('activerecord.attributes.article.updated_by')
      old_id = @article.updated_by_id_was
      old_value = User.find(old_id).display_name if old_id
      new_value = @article.updated_by.try(:display_name)
    when 'picture_id'
      label = t('activerecord.attributes.article.picture')
      old_value = value[0]
      new_value = value[1]
    else
      label = t("activerecord.attributes.article.#{key}")
      old_value = value[0]
      new_value = value[1]
    end

    [label, old_value, new_value]
  end

end

