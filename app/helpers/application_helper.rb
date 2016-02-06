module ApplicationHelper

  ROTATION_CLASS = [
    'rotate_4',
    'rotate_minus_4',
    'rotate_8',
    'rotate_minus_8',
    'rotate_12',
    'rotate_minus_12',
    'rotate_16',
    'rotate_minus_16'
    # 'rotate_20',
    # 'rotate_minus_20',
    # 'rotate_24',
    # 'rotate_minus_24'
  ].freeze

  BOX_SHADOW_CLASS = [
    'box_shadow_bottom_full',
    'box_shadow_bottom_left',
    'box_shadow_bottom_right',
    'box_shadow_bottom_both'
  ].freeze

  QUESTION_MARK_IMAGE_URL = '/assets/question_mark.svg'.freeze

  def fonticon(iconname, customclass = '')
    # haml_tag :i, :class => "fi-#{iconname} #{customclass} fonticon"
    "<i class='fi-#{iconname} #{customclass} fonticon'></i>".html_safe
  end

  def random_rotation_class
    ROTATION_CLASS.sample
  end

  def random_box_shadow_class
    BOX_SHADOW_CLASS.sample
  end

  def image_tag_for_picture(picture, img_size = :thumb)
    return nil if picture.blank? || picture.image.blank?
    image_tag(picture.image.url(img_size))
  end

  def image_thumb_url_or_fallback(picture)
    return QUESTION_MARK_IMAGE_URL if picture.blank?
    picture.image.url(:thumb)
  end

  def format_time(timeval, timeformat = :db_no_tz)
    return nil if timeval.blank?

    timeval.to_s(timeformat)
  end

  def title_for_game(game)
    return '' unless game
    return game.name unless game.house

    game_name = game.name
    house_name = game.house.try(:name)

    if house_name != game_name
      "#{game_name} (#{house_name})"
    else
      game_name
    end
  end

end

