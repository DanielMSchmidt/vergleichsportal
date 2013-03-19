$("#provider").html('<%= escape_javascript(render :partial => "home/admin/provider") %>');
errornote("Anbieter <%= @provider.name %> wurde aktualisiert!", "success");