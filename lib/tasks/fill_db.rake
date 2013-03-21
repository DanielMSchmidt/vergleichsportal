#encoding: utf-8
namespace :db do
  desc "Fill the Database with initial data"
  task :initialize => :environment do
    Rake::Task['db:reset'].invoke

    #Create Providers
    Provider.create!(name: 'Ebay',
                     display_name: 'Ebay.de',
                     url: 'http://www.ebay.de',
                     image_url: 'http://pics.ebaystatic.com/aw/pics/announcements/new/logo/logo-fixed-cropped.png',
                     active: true)
    Provider.create!(name: 'BuchDe',
                     display_name: 'Buch.de',
                     url: 'http://www.buch.de',
                     image_url: 'http://www.gruenderszene.de/datenbank/uploads/company_normal/buch-de.jpg',
                     active: true)
    Provider.create!(name: 'ThaliaDe',
                     display_name: 'Thalia.de',
                     url: 'http://www.thalia.de',
                     image_url: 'http://www.thalia.de/buch-resources/mandant/thalia11/img/logo_thalia.png',
                     active: true)
    Provider.create!(name: 'BuecherDe',
                     display_name: 'Bücher.de',
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

    #for Admin Role
    r2 = Role.create!(name: "Admin")
    p5 = Permission.create!(value: "lock_user")
    p6 = Permission.create!(value: "modify_ad")
    p7 = Permission.create!(value: "view_statistic")
    p8 = Permission.create!(value: "enable_provider")
    PermissionRoleAssignment.create!(role_id: r2.id, permission_id: p5.id)
    PermissionRoleAssignment.create!(role_id: r2.id, permission_id: p6.id)
    PermissionRoleAssignment.create!(role_id: r2.id, permission_id: p7.id)
    PermissionRoleAssignment.create!(role_id: r2.id, permission_id: p8.id)


  end
end