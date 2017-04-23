<% if @player %>
$('#myModalLabel').html("<%=@player.name%>'s Scores")
<% elsif @round %>
$('#myModalLabel').html("Round <%=@round%>")
<% end %>
$('#myModal').find('.modal-body').html('<%= j render('players/scores') %>')
