$("#cart").html("<%= escape_javascript(render @active_cart.articles, search: false) %>");
$("#change-cart").html("<%= escape_javascript(render @active_cart) %>");
errornote("Artikel wurde hinzugefügt!", "success");
location.reload();