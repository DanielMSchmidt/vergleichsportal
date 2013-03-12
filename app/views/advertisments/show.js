alert("Erfolgreich aktualisiert");
$('add-advertisment-modal').trigger('reveal:close');
$('#aktive_ad').add('<%= render @advertisment %>')