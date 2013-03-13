# encoding: UTF-8

Angenommen(/^es gibt einen Administrator$/) do
  user = User.create(:email => 'admin@root.de', :password => 'safd234')
  role = Role.create(:name => 'admin')
  UserRoleAssignment.create(:user_id user, :role_id role)
  
end
Angenommen(/^es gibt mindestens eine Werbung mit Bild\-URL "(.*?)" und Link\-URL "(.*?)"$/) do |arg1, arg2|
  Advertisment.create(:linkurl => arg2, :imgurl => arg1, active = false)
end

Wenn(/^ich trage die neue Bild\-URL "(.*?)"$/) do |arg1|
  visit 'home/admin'
  within("#advertisment" Advertisment.last.id) do
    fill_in "image_url", :with => arg1
  end
end

Wenn(/^die neue Link\-URL "(.*?)" in die Maske ein$/) do |arg1|
  visit 'home/admin'
  within("#advertisment") do
    fill_in "link_url", :with => arg1
  end
end

Wenn(/^ich klicke auf "(.*?)"$/) do |arg1|
  visit 'home/admin'
  within("#advertisment" Advertisment.last.id) do
    click_link 'speichern'
  end
end

Dann(/^die geänderte Werbung sollte die Bild\-URL "(.*?)" und die Link\-URL "(.*?)" haben$/) do |arg1, arg2|
  ad = Advertisment.last
  # check URLs
end

Angenommen(/^es gibt einen Admin mit der E\-Mailadresse "(.*?)" und dem Passwort "(.*?)"\.$/) do |arg1, arg2|
  user = User.create(:email => arg1, :password => arg2)
  role = Role.create(:name => 'admin')
  UserRoleAssignment.create(:user_id user, :role_id role) 
end

Angenommen(/^dieser ist angemeldet und ist auf der "(.*?)"\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^es gibt den Nutzer(\d+) mit der E\-Mailadresse "(.*?)" und dem Passwort "(.*?)" mit dem Administratorstatus false$/) do |arg1, arg2, arg3|
  user = User.create(:email => arg2, :password => arg3)
  role = Role.create(:name => 'user')
  UserRoleAssignment.create(:user_id user, :role_id role) 
end

Wenn(/^der Nutzer auf den Button "(.*?)" des Nutzer(\d+) klickt$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte dieser den Administratorstatus "(.*?)" bekommen\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^der Nutzer(\d+) den Administratorstatus "(.*?)" haben$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Dann(/^der Button "(.*?)" darf nicht sichtbar sein\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^dieser ist angemeldet und ich bin auf der "(.*?)"\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^das Sperrflag flase$/) do
  pending # express the regexp above with the code you wish you had
end

Wenn(/^der Nutzer auf den Button Sperren des Nutzer(\d+) klickt$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte dieser gesperrt sein\.$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^der Nutzer(\d+) sollte das Sperrflag "(.*?)" haben$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^es gibt den Administrator$/) do
  user = User.create(:email => 'admin@root.de', :password => 'safd234')
  role = Role.create(:name => 'admin')
  UserRoleAssignment.create(:user_id user, :role_id role)
end

Angenommen(/^es gibt eine aktive Werbung$/)
  Advertisment.create(:linkurl => 'google.de', :imgurl => 'google.de/test.jpg', :active => true)
end

Angenommen(/^die Werbung die gelöscht werden soll hat den Status inaktiv$/) do
  Advertisment.create(:linkurl => 'google.de', :imgurl => 'google.de/test.jpg', :active => false)
end

Dann(/^die Werbung wurde gelöscht true$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^die Werbung wurde gelöscht false$/) do
  pending # express the regexp above with the code you wish you had
end

Wenn(/^der Nutzer auf den Button löschen des Nutzer(\d+) klickt$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte dieser sich nicht mehr im System befinden\.$/) do
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^ich suche nach "(.*?)"$/) do |arg1|
  visit '/home/index'
  fill_in 'ten mobile-three columns', :with => arg1
  click_link 'two mobile-one columns'
end

Angenommen(/^mein Warenkorb hat ein Element$/) do
  artikel1 = Article.create(:ean => "1234567-12345-1", :description => 'Beschreibung', :name => arg1)
  cart = Cart.create()
  ArticleCartAssignment(:cart_id => cart, :article_id => artikel1)
end

Wenn(/^ich auf Warenkorb klicke$/) do
  pending # express the regexp above with the code you wish you had
end

Wenn(/^ich auf Artikel entfernen klicke$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte der aktuelle Warenkorb leer sein$/) do
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^es gibt einen Warenkorb mit dem Artikel "(.*?)" und dem Artikel "(.*?)"$/) do |arg1, arg2|
  artikel1 = Article.create(:ean => "1234567-12345-1", :description => 'Beschreibung', :name => arg1)
  artikel2 = Article.create(:ean => "1234567-12345-1", :description => 'Beschreibung', :name => arg2)
  cart = Cart.create()
  ArticleCartAssignment(:cart_id => cart, :article_id => artikel1)
  ArticleCartAssignment(:cart_id => cart, :article_id => artikel2)
end

Angenommen(/^der Artikel "(.*?)" hat bei dem Provider ebay\.de den Preis (\d+) und bei dem Provider buch\.de den Preis (\d+)$/) do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Wenn(/^wenn ich auf "(.*?)" klicke$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^es wird "(.*?)" angezeigt$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^als Resultat wird buch\.de angezeigt$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^als Resultat wird ebay\.de angezeigt$/) do
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^es gibt einen einfachen Nutzer mit der E\-Mailadresse "(.*?)" und dem Passwort "(.*?)"$/) do |arg1, arg2|
  user = User.create(:email => arg1, :password => arg2)
  role = Role.create(:name => 'user')
  UserRoleAssignment.create(:user_id user, :role_id role)
end

Angenommen(/^ich bin auf der "(.*?)" Seite$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Wenn(/^ich gebe als Mailadresse "(.*?)" und als Passwort "(.*?)" ein$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Wenn(/^ich klicke auf "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte ich eingeloggt sein$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^ich sollte auf der "(.*?)" sein$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^es gibt den Admin mit der E\-Mailadresse "(.*?)" und dem Passwort "(.*?)"$/) do |arg1, arg2|
  user = User.create(:email => arg1, :password => arg2)
  role = Role.create(:name => 'admin')
  UserRoleAssignment.create(:user_id user, :role_id role)
end

Angenommen(/^es gibt noch keinen Nutzer$/) do
  pending # express the regexp above with the code you wish you had
end

Wenn(/^ich gebe als Mailadresse "(.*?)" ein$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Wenn(/^ich gebe als Passwort "(.*?)" ein$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte ich nicht eingeloggt sein$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^es sollte eine E\-Mail an mich versandt worden sein$/) do
  pending # express the regexp above with the code you wish you had
end

Dann(/^es sollte eine E\-Mail versendet werden$/) do
  pending # express the regexp above with the code you wish you had
end
Angenommen(/^es gibt den Administrator und eine aktive Werbung "(.*?)" und weitere Werbungen$/) do |arg1|
  user = User.create(:email => 'admin@root.de', :password => 'safd234')
  role = Role.create(:name => 'admin')
  UserRoleAssignment.create(:user_id user, :role_id role)
  Advertisment.create(:linkurl => 'google.de', :imgurl => 'google.de/test.jpg', :active => false)
  Advertisment.create(:linkurl => 'google.de', :imgurl => 'google.de/test.jpg', :active => true)
end

Angenommen(/^ich bin auf der "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Angenommen(/^ich klicke auf den Banner einer Werbung "(.*?)" mit Status  "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Dann(/^sollte ich auf der "(.*?)" sein$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Dann(/^die Werbung "(.*?)" hat den Status aktiv "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Dann(/^die Werbung "(.*?)" hat den Status "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end
