$(function(){
  setTimeout(function(){ $('#flash div').hide('blind', 500) }, 2500);
  $('.replacement').click(function(){
    $(this).next('div:not(:visible)').show().prepend('<a href="#" class="close">x</div>').end().remove();
    return false;
  })
  $('.replace .close').live('click', function(){
    $(this).parent().hide('blind', function(){$(this).remove()})
  })
  $('#search-items .item .searchable').highlightRegex(new RegExp($('#search-items #query').text(), 'gi'));
})