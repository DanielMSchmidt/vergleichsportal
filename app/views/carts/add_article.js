$("#cart").html("<%= escape_javascript(render @active_cart.articles, search: false) %>");
$("#change-cart").html("<%= escape_javascript(render @active_cart) %>");
errornote((t "carts.article_added"), "success");
location.reload();