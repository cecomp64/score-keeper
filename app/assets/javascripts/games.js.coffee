# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# <input id="game_name" name="game[name]" placeholder="Name of the Game" type="text">

init_selectables = ->
  $('.selectable').each (i, obj) ->
    $(obj).click( ->
      value = $(obj).data('value')
      field = $(obj).data('field') || 'selectable'
      selected = $(obj).hasClass('selected')
      console.log('Clicked ' + value)

      if(selected)
        $(obj).removeClass('selected')
        # Remove hidden form element
        $(obj).children('#' + field + '_' + value).remove()
      else
        $(obj).addClass('selected')
        # Add hidden form element
        $(obj).append('<input id="' + field + '_' + value + '" name="' + field + '[]" type="hidden" value="' + value + '">')

    )

document.addEventListener "turbolinks:load", (event) ->
  init_selectables()
#$(document).ready(init_selectables)
#$(document).on('page:load', init_selectables)