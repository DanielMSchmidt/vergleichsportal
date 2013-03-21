$("#carts").html("<%= escape_javascript(render @active_cart.articles, search: false) %>");
$("#change-cart").html("<%= escape_javascript(render @active_cart) %>");
errornote("Artikel wurde entfernt!", "success");
location.reload();