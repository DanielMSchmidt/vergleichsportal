$("#provider").html('<%= escape_javascript(render :partial => "home/admin/provider") %>');
errornote('<%= t "providers.add_provider" %>', "success");
