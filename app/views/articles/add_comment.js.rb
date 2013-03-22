<% if @comment.id %>
  alert('<%=(t "articles.comment_thanks")%>');
<% else %>
  alert('<%=(t "articles.comment_error") %>');
<% end %>