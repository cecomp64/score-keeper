<% @score_ids.each do |sid| %>
$('#score_<%=sid%>').html('<%=@value%>')
<% end %>