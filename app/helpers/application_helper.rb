# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def replacement_link(text, options = {}, &blk)
    concat(content_tag('div', {:class => 'replace'}.merge(options)) do
      link_to(text, '#', :class => 'replacement') +
        content_tag('div', :style => 'display:none', &blk)
    end)
  end
end
