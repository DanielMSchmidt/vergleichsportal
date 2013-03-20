namespace :db do
  desc "Fill the Database with initial data"
  task :initialize => :environment do
    Rake::Task['db:reset'].invoke

    #Create Providers
    Provider.create!(name: 'Ebay',
                     url: 'http://www.ebay.de',
                     image_url: 'http://pics.ebaystatic.com/aw/pics/announcements/new/logo/logo-fixed-cropped.png',
                     active: true)
    Provider.create!(name: 'BuchDe',
                     url: 'http://www.buch.de',
                     image_url: 'http://www.gruenderszene.de/datenbank/uploads/company_normal/buch-de.jpg',
                     active: true)
    Provider.create!(name: 'ThaliaDe',
                     url: 'http://www.thalia.de',
                     image_url: 'http://www.thalia.de/buch-resources/mandant/thalia11/img/logo_thalia.png',
                     active: true) 
    Provider.create!(name: 'BuecherDe',
                     url: 'http://www.buecher.de',
                     image_url: 'http://bilder.buecher.de/images/logo_transp.gif',
                     active: true)

    #Create Guest User
    Role.create!(name: 'Guest')


    #Create Permissions
    #for User Role
    r1 = Role.create!(name: "Registered User")
    p1 = Permission.create!(value: "create_comment")
    p2 = Permission.create!(value: "create_rating")
    p3 = Permission.create!(value: "switch_cart")
    p4 = Permission.create!(value: "compare_cart")
    PermissionRoleAssignment.create!(role_id: r1.id, permission_id: p1.id)
    PermissionRoleAssignment.create!(role_id: r1.id, permission_id: p2.id)
    PermissionRoleAssignment.create!(role_id: r1.id, permission_id: p3.id)
    PermissionRoleAssignment.create!(role_id: r1.id, permission_id: p4.id)


  end
end