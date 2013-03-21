<% if @comment.id %>
  alert("Danke für die Bewertung!");
<% else %>
  alert("Der Kommentar ist zu kurz oder zu lang!");
<% end %>