$("div#register-form").replaceWith("<%= escape_javascript(render :partial => 'users/success') %>");
$(".user_control").replaceWith("<%= escape_javascript(render :partial => 'layouts/navigation_logout') %>");
