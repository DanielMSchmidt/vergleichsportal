$ ->
  $(".accordion #statistics").click ->
    new Chart($("#statistics .content canvas").get(0).getContext("2d")).Line(data, options);