$('#edit-user-modal').trigger('reveal:close');
$("div#update-form").replaceWith("<%= escape_javascript(render :partial => 'users/update_form') %>");