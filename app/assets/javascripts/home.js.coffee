$ ->
  options = {}
  $(".accordion #statistics").click ->
    new Chart($("#statistics .content canvas").get(0).getContext("2d")).Line(statistics_data, options)
  $("#cart-modal-button").click ->
    new Chart($("#compare-cart-modal canvas").get(0).getContext("2d")).Line(price_history_graph_data, options)

  $("#search_term").css('color', 'black')