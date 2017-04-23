$('#myModal').modal('hide')

<% @score_ids.each do |sid| %>
<% value = @form_scores.is_a?(Hash) ? @form_scores[sid].to_i : @value %>
$('#score_<%=sid%>').html('<%=value%>')
$('#score_<%=sid%>').data('score', '<%=value%>')
$('#score_<%=sid%>').fadeOut(500).fadeIn(1000)
<% end %>

<% @players.each do |player| %>
<% total = player.total_score(@game) %>
$('#player_<%=player.id%>_total').html('<%= total %>')
$('#player_<%=player.id%>_total').data('score', '<%= total %>')
$('#player_<%=player.id%>_total').fadeOut(500).fadeIn(1000)
<% end %>