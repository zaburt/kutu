module ApplicationHelper

  def fonticon(iconname, customclass = '')
    # haml_tag :i, :class => "fi-#{iconname} #{customclass} fonticon"
    "<i class='fi-#{iconname} #{customclass} fonticon'></i>".html_safe
  end


end

