$("#cart").html("<%= escape_javascript(render @cart.articles, search: false) %>");
$("#change-cart").html("<%= escape_javascript(render @cart) %>");
errornote("Artikel wurde hinzugefügt!", "success");