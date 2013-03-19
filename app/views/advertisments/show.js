$('#add-advertisment-modal').trigger('reveal:close');
$(".alert").hide();
$("small").hide();
$(".error").removeClass("error");
$("#active-ad").html("<%= escape_javascript(render @active_advertisments)%>");
$("#ad-list").html("<%= escape_javascript(render @inactive_advertisments)%>");
errornote("Werbung wurde hinzugefügt!", "success");