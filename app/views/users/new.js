<% if @user.save %>
  $("div#register-form").replaceWith("<%= escape_javascript(render :partial => 'users/success') %>");
<% else %>
  $("div#register-form").replaceWith("<%= escape_javascript(render :partial => 'users/form') %>");
<% end %>