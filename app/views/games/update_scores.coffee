<% @score_ids.each do |sid| %>
$('#score_<%=sid%>').html('<%=@value%>')
$('#score_<%=sid%>').fadeOut(500).fadeIn(1000)
<% end %>