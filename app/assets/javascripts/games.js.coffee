# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@init_players = ->
  $('.player-modal').each( (i,obj) ->
    modal = $(obj).data('modal')
    game = $(obj).data('game')
    player = $(obj).data('player')

    $(obj).click( ->
      # Clear the existing data
      $(modal).find('.modal-body').html('')
      $(modal).find('.modal-title').html('Loading...')

      # Query for the player's data
      $.ajax('/player_info.js', {data: {game: game, id: player}})

      # Show the data
      $(modal).modal('show')
    )
  )


# Specific functions
@selectScore = (obj, selected) ->
  form = $(obj).data('form') || obj
  value = $(obj).data('value')
  score = $(obj).data('score')

  #console.log('[I] selectScore - ' + printData($(obj).data()))
  console.log('[I] selectScore - value: ' + value + ' score: ' + score + ' form: ' + form + ' selected: ' + selected)

  if(selected)
    $('#score').val(score)


@initScoreButtons = ->
  # Adding a new round should be a call back to the server...
  #$('.score-round').click( ->
    # Add a new round row
    # Update next-round
  #)

  #$('.score-submit').click( ->
    # Update scores in table
    #score_form = $('#score-control')
    #score_ids = $(score_form).children()
    # Update scores in database
  #)

  $('.score-updater').each (i, obj) ->
    $(obj).click( ->
      updater = $(obj).data()
      score = parseInt($('#score').val())
      score += parseInt(updater.value)
      $('#score').val(score)
    )

# Generic Functions....

@printData = (obj, selected=false) ->
  str = ''
  for key in obj
    console.log(key + ': ' + obj[key])
    str += key + ': ' + obj[key] + ' '

  return str


@sanitizeSelector = (sel) ->
  sel.replace( /(:|\.|\[|\]|,|=|@)/g, "\\$1" )

@updateForm = (obj, selected)->
  console.log('update!')
  value = $(obj).data('value')
  field = $(obj).data('field') || 'selectable'
  form = $(obj).data('form') || obj

  console.log('[I] updateForm - value: ' + value + ' field: ' + field + ' form: ' + form)
  id = field + value
  id = id.replace(/[\[\]]/g, '_')

  if(!selected)
    $(form).children('#' + id).remove()
  else
    $(form).append('<input id="' + id + '" name="' + field + '[]" type="hidden" value="' + value + '"/>')

@init_selectables = ->
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

      selected = !selected

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
  initScoreButtons()
  init_players()

#$(document).ready(init_selectables)
#$(document).on('page:load', init_selectables)