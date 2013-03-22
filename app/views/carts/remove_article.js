$("#cart-modal").trigger('reveal:close');

<% # refresh modals %>
$("#switch-cart-modal").replaceWith("<%= escape_javascript(render :partial => 'shared/modal/switch_cart') %>"); 
$("#cart-modal").replaceWith("<%= escape_javascript(render :partial => 'shared/modal/cart') %>"); 
$("#compare-cart-modal").replaceWith("<%= escape_javascript(render :partial => 'shared/modal/compare_cart') %>"); 

$("#cart-modal").reveal();

errornote('<%=(t "carts.article_removed")%>', "success");
reloadStars();
