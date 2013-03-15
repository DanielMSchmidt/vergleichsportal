$(".user#<%= @user_id %>").hide();
$('#user-delete-modal<%= @user_id %>').trigger('reveal:close');