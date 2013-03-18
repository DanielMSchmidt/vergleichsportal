namespace :db do
  desc "Fill the Database with initial data"
  task :initialize => :environment do
    Rake::Task['db:reset'].invoke

    #Create Providers
    Provider.create!(name: 'Ebay',
                     url: 'www.ebay.de',
                     image_url: 'http://pics.ebaystatic.com/aw/pics/announcements/new/logo/logo-fixed-cropped.png',
                     active: true)
    Provider.create!(name: 'BuchDe',
                     url: 'www.buch.de',
                     image_url: 'http://www.gruenderszene.de/datenbank/uploads/company_normal/buch-de.jpg',
                     active: true)
    Provider.create!(name: 'ThaliaDe',
                     url: 'www.thalia.de',
                     image_url: 'http://www.thalia.de/buch-resources/mandant/thalia11/img/logo_thalia.png',
                     active: true) 
    Provider.create!(name: 'BuecherDe',
                     url: 'www.buecher.de',
                     image_url: 'http://bilder.buecher.de/images/logo_transp.gif',
                     active: true)
  end
end