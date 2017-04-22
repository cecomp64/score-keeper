$('#myModalLabel').html("<%=@player.name%>'s Scores")
$('#myModal').find('.modal-body').html('<%= j render('players/scores') %>')
