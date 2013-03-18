$("#active-ad").html("<%= escape_javascript(render @active_advertisments)%>");
$("#ad-list").html("<%= escape_javascript(render @inactive_advertisments)%>");
errornote("Werbung wurde aktiviert!", "success");