# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Specific functions
@selectScore = (obj, selected) ->
  console.log('[I] selectScore')

# Generic Functions....

@updateForm = (obj, selected)->
  console.log('update!')
  value = $(obj).data('value')
  field = $(obj).data('field') || 'selectable'
  form = $(obj).data('form') || obj

  console.log('[I] updateForm - value: ' + value + ' field: ' + field + ' form: ' + form)
  id = field + value
  id = id.replace(/[\[\]]/g, '_')

  if(selected)
    $(form).children('#' + id).remove()
  else
    $(form).append('<input id="' + id + '" name="' + field + '[]" type="hidden" value="' + value + '"/>')

init_selectables = ->
  $('.selectable').each (i, obj) ->
    $(obj).click( ->
      actions = $(obj).data('actions')

      # Parse out a list of functions to call
      actions = if(actions == undefined) then [] else actions.split(',')

      selected = $(obj).hasClass('selected')
      console.log('Clicked.  actions: ' + actions)

      # Always go ahead and add/remove the selected class
      if(selected)
        $(obj).removeClass('selected')
      else
        $(obj).addClass('selected')

      # Iterate over all actions
      $.each(actions, (i, action)->
        fn = window[action]
        if(typeof(fn) == 'function')
          fn(obj, selected)
        else
          console.log('[E] Could not find function to execute: ' + action)
      )

    ) # click()

document.addEventListener "turbolinks:load", (event) ->
  init_selectables()

#$(document).ready(init_selectables)
#$(document).on('page:load', init_selectables)