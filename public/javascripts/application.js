$(function(){
  setTimeout(function(){ $('#flash div').hide('blind', 500) }, 2500);
  $('.replacement').click(function(){
    $(this).next('div:not(:visible)').show().end().remove();
    return false;
  })
  $('#search-items .item').highlightRegex(new RegExp($('#search-items #query').text()));
})