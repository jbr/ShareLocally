# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def replacement_link(text, options = {}, &blk)
    innermost = link_to(text, '#', :class => 'replacement')
    innermost += content_tag('div', capture_haml(&blk), :style => 'display:none')
    concat content_tag('div', innermost, {:class => 'replace'}.merge(options))
  end
end
