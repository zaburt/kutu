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
  ]

  BOX_SHADOW_CLASS = [
    'box_shadow_bottom_full',
    'box_shadow_bottom_left',
    'box_shadow_bottom_right',
    'box_shadow_bottom_both'
  ]

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

end

