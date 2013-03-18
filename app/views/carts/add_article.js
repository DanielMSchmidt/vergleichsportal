$("#cart").html("<%= escape_javascript(render @cart.articles, search: false) %>");
errornote("Artikel wurde hinzugefügt!", "success");