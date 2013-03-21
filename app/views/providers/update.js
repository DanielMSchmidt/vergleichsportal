$("#provider").html('<%= escape_javascript(render :partial => "home/admin/provider") %>');
errornote("Anbieter <%= @provider.display_name %> wurde aktualisiert!", "success");