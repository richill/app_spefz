# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CategoryAge.delete_all
ca01 = CategoryAge.create!(name:'18 - 24')
ca02 = CategoryAge.create!(name:'25 - 34')
ca03 = CategoryAge.create!(name:'35 - 44')
ca04 = CategoryAge.create!(name:'45 - 54')
ca05 = CategoryAge.create!(name:'55 - 64')
ca06 = CategoryAge.create!(name:'65+')
ca07 = CategoryAge.create!(name:'All Ages')

CategoryBlog.delete_all
cb01 = CategoryBlog.create!(name:'News')
cb02 = CategoryBlog.create!(name:'Venues')
cb03 = CategoryBlog.create!(name:'Networking Tips')
cb04 = CategoryBlog.create!(name:'Dating Tips')

CategoryCountry.delete_all
cc01 = CategoryCountry.create!(name:'United Kingdom')

CategoryContactclient.delete_all
ccc01 = CategoryContactclient.create!(name:'Spefz Member')
ccc02 = CategoryContactclient.create!(name:'Spefz Partner')
ccc03 = CategoryContactclient.create!(name:'Press & Media')
ccc04 = CategoryContactclient.create!(name:'Affiliates')
ccc05 = CategoryContactclient.create!(name:'Other')

CategoryEnquiry.delete_all
ceq01 = CategoryEnquiry.create!(name:'General Enquiry')
ceq02 = CategoryEnquiry.create!(name:'Technical Support')
ceq03 = CategoryEnquiry.create!(name:'Partnership')
ceq04 = CategoryEnquiry.create!(name:'Suggestions')
ceq05 = CategoryEnquiry.create!(name:'Compliants')
ceq06 = CategoryEnquiry.create!(name:'Feedback')
ceq07 = CategoryEnquiry.create!(name:'Creating a Social')
ceq08 = CategoryEnquiry.create!(name:'Booking an Event')
ccc09 = CategoryEnquiry.create!(name:'Marketing')
ccc10 = CategoryEnquiry.create!(name:'Affiliates')
ccc11 = CategoryEnquiry.create!(name:'Advertising on Spefz')
ccc12 = CategoryEnquiry.create!(name:'Suggest a Partnership')
ccc13 = CategoryEnquiry.create!(name:'Customer Service')
ceq14 = CategoryEnquiry.create!(name:'End Subscription Plan')
ceq15 = CategoryEnquiry.create!(name:'Delete Account')
ceq16 = CategoryEnquiry.create!(name:'I would love to work at Spefz')

CategoryGender.delete_all
cg01 = CategoryGender.create!(name:'Male')
cg02 = CategoryGender.create!(name:'Female')

CategoryInvite.delete_all
ci01 = CategoryInvite.create!(name:'just my guest')
ci02 = CategoryInvite.create!(name:'open to everyone')

CategoryInviteoption.delete_all
cio01 = CategoryInviteoption.create!(name:'Only members in my network')
cio02 = CategoryInviteoption.create!(name:'Every member')
cio03 = CategoryInviteoption.create!(name:'No one')

CategoryQuantitygender.delete_all
cqg01 = CategoryQuantitygender.create!(name:'only men')
cqg02 = CategoryQuantitygender.create!(name:'only women')
cqg03 = CategoryQuantitygender.create!(name:'both men & women')
cqg04 = CategoryQuantitygender.create!(name:'both X men & X women')

CategoryQuantitygendersocial.delete_all
cqg01 = CategoryQuantitygendersocial.create!(name:'only men')
cqg02 = CategoryQuantitygendersocial.create!(name:'only women')
cqg03 = CategoryQuantitygendersocial.create!(name:'both men & women')

CategoryReport.delete_all
crt01 = CategoryReport.create!(name:'Inappropriate content or behaviour')
crt02 = CategoryReport.create!(name:'Spamming / commercial')

CategoryTopic.delete_all
ct01 = CategoryTopic.create!(name:'Activity Social')
ct02 = CategoryTopic.create!(name:'Auto, Boat & Air')
ct03 = CategoryTopic.create!(name:'Business Professional')
ct04 = CategoryTopic.create!(name:'Charity & Causes')
ct05 = CategoryTopic.create!(name:'Community & Culture')
ct06 = CategoryTopic.create!(name:'Family & Education')
ct07 = CategoryTopic.create!(name:'Fashion & Beauty')
ct08 = CategoryTopic.create!(name:'Film, Media & Entertainment')
ct09 = CategoryTopic.create!(name:'Food & Drink')
ct10 = CategoryTopic.create!(name:'Fundraising')
ct11 = CategoryTopic.create!(name:'Government & Politics')
ct12 = CategoryTopic.create!(name:'Health & Wellness')
ct13 = CategoryTopic.create!(name:'Hobbies & Special Interest')
ct14 = CategoryTopic.create!(name:'Home & Lifestyle')
ct15 = CategoryTopic.create!(name:'Key and Lock Parties')
ct16 = CategoryTopic.create!(name:'Music')
ct17 = CategoryTopic.create!(name:'Performing & Visual Arts')
ct18 = CategoryTopic.create!(name:'Race & Culture')
ct19 = CategoryTopic.create!(name:'Religion & Spirituality')
ct20 = CategoryTopic.create!(name:'Science & Technology')
ct21 = CategoryTopic.create!(name:'Social Impact')
ct22 = CategoryTopic.create!(name:'Special Social Event')
ct23 = CategoryTopic.create!(name:'Sports & Fitness')
ct24 = CategoryTopic.create!(name:'Travel & Outdoors')
ct25 = CategoryTopic.create!(name:'Tech Stories')
ct26 = CategoryTopic.create!(name:'Valentines Social')

CategoryRole.delete_all
cr01 = CategoryRole.create!(name:'Admin')
cr02 = CategoryRole.create!(name:'Primary Admin')
cr03 = CategoryRole.create!(name:'Client')

CategoryManagementgroup.delete_all
cmr01 = CategoryManagementgroup.create!(name:'Account Group')
cmr02 = CategoryManagementgroup.create!(name:'Administration Group')
cmr03 = CategoryManagementgroup.create!(name:'Client Group')
cmr04 = CategoryManagementgroup.create!(name:'Client Guest Group') #users who do not need to subscribe use site
cmr05 = CategoryManagementgroup.create!(name:'Development Group')
cmr06 = CategoryManagementgroup.create!(name:'Dummy Group')
cmr07 = CategoryManagementgroup.create!(name:'Event Management Group')
cmr08 = CategoryManagementgroup.create!(name:'Management Group') #superior group
cmr09 = CategoryManagementgroup.create!(name:'Sales/Marketing Group')

Subscription.delete_all
sb01 = Subscription.create!(title:'premium', price: 15.0, reference: 'SPz_x4Hrmg')


Venue.delete_all
vn01 = Venue.new(
  venuename: 'DSTRKT', 
  address: '9 rupert street',
  postcode: 'W1D 6DG',
  maplink: 'https://www.google.co.uk/maps/place/DSTRKT+London/@51.510398,-0.1345497,17z/data=!3m1!4b1!4m5!3m4!1s0x487604d3c9fed13f:0xf849d7c87bee3afa!8m2!3d51.510398!4d-0.132361',
  station: 'picadilly circus',
  contact: '020 7317 9120',
  website: 'http://www.dstrkt-london.com/home',
  category_country_id: cc01.id,
  city: 'london'
  )
vn01.save!

Venue.delete_all
vn02 = Venue.new(
  venuename: 'core (cockatil lounge)', 
  address: '10 - 15 queen street (aldermary house)',
  postcode: 'EC4N 1TX',
  maplink: 'https://www.google.co.uk/maps?client=safari&rls=en&oe=UTF-8&gfe_rd=cr&q=core+(cocktail+lounge)+10+-+15+queen+street+(aldermary+house)+EC4N+1TX&um=1&ie=UTF-8&sa=X&ved=0ahUKEwij4O_49ZnSAhVsLsAKHUwYCPwQ_AUICCgB',
  station: 'maison house',
  contact: '020 7618 9020',
  website: 'http://www.corebar.co.uk',
  category_country_id: cc01.id,
  city: 'london'
  )
vn02.save!

Venue.delete_all
vn03 = Venue.new(
  venuename: 'fifty 9', 
  address: 'lansdowne house (59 berkeley square)',
  postcode: 'W1J 6ER',
  maplink: 'https://www.google.co.uk/maps/place/Fifty9+Bar/@51.5090151,-0.1467647,17z/data=!3m1!4b1!4m5!3m4!1s0x487605296f787695:0x39ecb096cf5737cc!8m2!3d51.5090151!4d-0.144576',
  station: 'green park',
  contact: '020 7758 8255',
  website: 'http://www.fifty9bar.co.uk/venue-details/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn03.save!

Venue.delete_all
vn04 = Venue.new(
  venuename: 'pullman hotel (golden arrow bar)', 
  address: '100 - 110 euston road',
  postcode: 'NW1 2AJ',
  maplink: 'https://www.google.co.uk/maps/place/Pullman+London+St+Pancras+Hotel/@51.5286903,-0.1301617,17z/data=!3m1!4b1!4m5!3m4!1s0x48761b3b18eb8f91:0xc259269dc1c840ab!8m2!3d51.5286903!4d-0.127973',
  station: 'kings cross',
  contact: '020 7666 9192',
  website: 'http://www.pullmanhotels.com/gb/hotel-5309-pullman-london-st-pancras/index.shtml',
  category_country_id: cc01.id,
  city: 'london'
  )
vn04.save!

Venue.delete_all
vn05 = Venue.new(
  venuename: 'eclipse (south kensington)', 
  address: '158 old brompton road',
  postcode: 'SW5 0BA',
  maplink: 'https://www.google.co.uk/maps/place/Eclipse/@51.4908941,-0.1853982,17z/data=!3m1!4b1!4m5!3m4!1s0x4876056123dde00d:0xf86cbc359b63767a!8m2!3d51.4908941!4d-0.1832095',
  station: 'gloucester road',
  contact: '020 7259 2577',
  website: 'http://www.eclipsebars.com',
  category_country_id: cc01.id,
  city: 'london'
  )
vn05.save!

Venue.delete_all
vn06 = Venue.new(
  venuename: 'the alice', 
  address: '133 Houndsditch',
  postcode: 'EC3A 7BX',
  maplink: 'https://www.google.co.uk/maps?client=safari&rls=en&q=the+alice+133+Houndsditch+EC3A+7BX&oe=UTF-8&gfe_rd=cr&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjFkpmB-JnSAhWGLMAKHcVGBHwQ_AUICCgB',
  station: 'aldgate',
  contact: '020 7929 0902',
  website: 'http://www.alicelondon.co.uk',
  category_country_id: cc01.id,
  city: 'london'
  )
vn06.save!

Venue.delete_all
vn07 = Venue.new(
  venuename: 'jewel (piccadilly)', 
  address: '4 - 6 glasshouse street',
  postcode: 'W1B 5DQ',
  maplink: 'https://www.google.co.uk/maps?client=safari&rls=en&q=jewel+(piccadilly)+4+-+6+glasshouse+street+W1B+5DQ&oe=UTF-8&gfe_rd=cr&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjdk5Gw-JnSAhUhAcAKHdQ1DlMQ_AUICCgB',
  station: 'picadilly circus',
  contact: '020 7439 4990',
  website: 'http://www.jewelpiccadilly.co.uk',
  category_country_id: cc01.id,
  city: 'london'
  )
vn07.save!

Venue.delete_all
vn08 = Venue.new(
  venuename: 'bar soho', 
  address: '23 - 25 old compton street',
  postcode: 'W1D 5JL',
  maplink: 'content',
  station: 'leicester square',
  contact: '020 7439 0439',
  website: 'http://www.barsoho.co.uk',
  category_country_id: cc01.id,
  city: 'london'
  )
vn08.save!

Venue.delete_all
vn09 = Venue.new(
  venuename: 'village', 
  address: '81 wardour street',
  postcode: 'W1D 6QD',
  maplink: 'https://www.google.co.uk/maps?q=village+81+wardour+street+W1D+6QD&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjGkYKqsbrSAhXILsAKHTlADpcQ_AUICCgB',
  station: 'picadilly circus',
  contact: '020 7434 2124',
  website: 'http://www.village-soho.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn09.save!

Venue.delete_all
vn10 = Venue.new(
  venuename: 'the somers town ', 
  address: '60 chalton street',
  postcode: 'NW1 1HS',
  maplink: 'https://www.google.co.uk/maps?q=the+somers+town+60+chalton+street+NW1+1HS&um=1&ie=UTF-8&sa=X&ved=0ahUKEwic26vbsbrSAhXlCcAKHeTMDUEQ_AUICCgB',
  station: 'euston',
  contact: '020 7387 7377',
  website: 'http://www.thesomerstowncoffeehouse.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn10.save!

Venue.delete_all
vn11 = Venue.new(
  venuename: 'kanaloa', 
  address: '18 lime office court (shoe lane)',
  postcode: 'EC4A 3BQ',
  maplink: 'https://www.google.co.uk/maps?q=kanaloa+18+lime+office+court+(shoe+lane)+EC4A+3BQ&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjnuO61srrSAhUXM8AKHYcfCTgQ_AUICCgB',
  station: 'chancery lane',
  contact: '020 7842 0620',
  website: 'http://www.kanaloaclub.com/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn11.save!

Venue.delete_all
vn12 = Venue.new(
  venuename: 'the pepys ', 
  address: 'stew lane (off upper thames street)',
  postcode: 'EC4V 3PT',
  maplink: 'https://www.google.co.uk/maps?q=the+pepys+stew+lane+(off+upper+thames+street)+EC4V+3PT&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjf0ubosrrSAhURM8AKHX3HD6cQ_AUICCgB',
  station: 'maison house',
  contact: '020 7489 1871',
  website: 'http://www.thepepys.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn12.save!

Venue.delete_all
vn13 = Venue.new(
  venuename: 'vivat bacchus (farringdon)', 
  address: '47 farringdon street, (entrance on charterhouse street)',
  postcode: 'EC4A 4LL ',
  maplink: 'https://www.google.co.uk/maps?q=vivat+bacchus+(farringdon)+47+farringdon+street,+(entrance+on+charterhouse+street)+EC4A+4LL&um=1&ie=UTF-8&sa=X&ved=0ahUKEwiWhYGQs7rSAhVLAsAKHd1XCZMQ_AUICCgB',
  station: 'chancery lane',
  contact: '020 7353 2648',
  website: 'http://www.vivatbacchus.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn13.save!

Venue.delete_all
vn14 = Venue.new(
  venuename: '155 bar & kitchen ', 
  address: '155 farringdon road',
  postcode: 'EC1R 3AD',
  maplink: 'https://www.google.co.uk/maps?q=155+bar+%26+kitchen+155+farringdon+road+EC1R+3AD&um=1&ie=UTF-8&sa=X&ved=0ahUKEwiFhaezs7rSAhXrCsAKHfftA-kQ_AUICCgB',
  station: 'farringdon',
  contact: '020 3675 8847',
  website: 'http://155barandkitchen.com/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn14.save!

Venue.delete_all
vn15 = Venue.new(
  venuename: 'millennium hotel (avista bar) ', 
  address: '44 grosvenor square',
  postcode: 'W1K 2HP',
  maplink: 'https://www.google.co.uk/maps/place/Millennium+Hotel+London+Mayfair/@51.5106308,-0.1531141,17z/data=!3m1!4b1!4m5!3m4!1s0x4876052d6b73b09f:0xec099f42b74eea8!8m2!3d51.5106308!4d-0.1509254',
  station: 'bond street',
  contact: '020 7629 9400',
  website: 'https://www.millenniumhotels.com/en/london/millennium-hotel-london-mayfair/?cid=gplaces',
  category_country_id: cc01.id,
  city: 'london'
  )
vn15.save!

Venue.delete_all
vn16 = Venue.new(
  venuename: 'brasserie blanc (threadneedle street)', 
  address: '60 threadneedle street',
  postcode: 'EC2R 8HP',
  maplink: 'https://www.google.co.uk/maps?q=brasserie+blanc+(threadneedle+street)+60+threadneedle+street+EC2R+8HP&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjZ7_CQtLrSAhVLDcAKHUPBD9sQ_AUICCgB',
  station: 'bank',
  contact: '020 7710 9440',
  website: 'http://brasserieblanc.com/restaurants/threadneedle-street/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn16.save!

Venue.delete_all
vn17 = Venue.new(
  venuename: 'tibits', 
  address: '12 - 14 heddon street',
  postcode: 'W1B 4DA',
  maplink: 'https://www.google.co.uk/maps?safe=strict&espv=2&q=tibits+12+-+14+heddon+street+W1B+4DA&bav=on.2,or.r_cp.&biw=1366&bih=609&dpr=1&ion=1&um=1&ie=UTF-8&sa=X&ved=0ahUKEwi7gb-1tLrSAhWlDMAKHQxwDMwQ_AUIBigB',
  station: 'picadilly circus',
  contact: '020 7758 4110',
  website: 'http://www.tibits.ch/en/home.html',
  category_country_id: cc01.id,
  city: 'london'
  )
vn17.save!

Venue.delete_all
vn18 = Venue.new(
  venuename: 'amber', 
  address: '1 ropemaker street (city point building)',
  postcode: 'EC2Y 9AW',
  maplink: 'https://www.google.co.uk/maps?q=amber+1+ropemaker+street+(city+point+building)+EC2Y+9AW&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjCwoTitLrSAhVjBsAKHVIyCj4Q_AUICCgB',
  station: 'liverpool street',
  contact: '020 7382 1690',
  website: 'http://amber-bar.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn18.save!

Venue.delete_all
vn19 = Venue.new(
  venuename: 'forge', 
  address: '24 cornhill',
  postcode: 'EC3V 3ND',
  maplink: 'https://www.google.co.uk/maps?q=forge+24+cornhill+EC3V+3ND&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjb9L6FtbrSAhUHKsAKHWtiCfsQ_AUICCgB',
  station: 'bank',
  contact: '020 7337 6767',
  website: 'http://www.forgedinlondon.com/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn19.save!

Venue.delete_all
vn20 = Venue.new(
  venuename: 'salvador and amanda', 
  address: '1 vernon place',
  postcode: 'WC1A 2EP ',
  maplink: 'https://www.google.co.uk/maps?q=salvador+and+amanda+1+vernon+place+WC1A+2EP&um=1&ie=UTF-8&sa=X&ved=0ahUKEwimwemhtbrSAhXHAsAKHdOoDI0Q_AUICCgB',
  station: 'holbon',
  contact: '020 7430 9600',
  website: 'http://www.salvadorandamanda.com/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn20.save!

Venue.delete_all
vn21 = Venue.new(
  venuename: 'the gable', 
  address: '25 moorgate',
  postcode: 'EC2R 6AR',
  maplink: 'https://www.google.co.uk/maps?q=the+gable+25+moorgate+EC2R+6AR&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjS3JDYtbrSAhWoLcAKHbIqB64Q_AUICCgB',
  station: 'bank',
  contact: '020 7330 0950',
  website: 'http://www.thegable.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn21.save!

Venue.delete_all
vn22 = Venue.new(
  venuename: 'all bar one bishopsgate', 
  address: '175 bishopsgate',
  postcode: 'EC2M 3YD',
  maplink: 'https://www.google.co.uk/maps?q=all+bar+one+bishopsgate+175+bishopsgate+EC2M+3YD&um=1&ie=UTF-8&sa=X&ved=0ahUKEwj1uNr1tbrSAhWFJsAKHZgWAXMQ_AUICCgB',
  station: 'liverpool street',
  contact: '020 7256 9450',
  website: 'http://www.allbarone.co.uk/national-search/london/all-bar-one-bishopsgate',
  category_country_id: cc01.id,
  city: 'london'
  )
vn22.save!

Venue.delete_all
vn23 = Venue.new(
  venuename: 'rileys sports bar', 
  address: '80 haymarket',
  postcode: 'SW1Y 4TE',
  maplink: 'https://www.google.co.uk/maps?q=rileys+sports+bar+80+haymarket+SW1Y+4TE&um=1&ie=UTF-8&sa=X&ved=0ahUKEwic-K2ytrrSAhWhC8AKHfCuBJYQ_AUICCgB',
  station: 'picadilly circus',
  contact: '020 7930 0393',
  website: 'http://www.rileyssportsbars.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn23.save!

Venue.delete_all
vn24 = Venue.new(
  venuename: 'woolgate bar and brasserie', 
  address: '25 basinghall street',
  postcode: 'EC2V 5HA',
  maplink: 'https://www.google.co.uk/maps?q=woolgate+bar+and+brasserie+(davy%27s)+25+basinghall+street+EC2V+5HA&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjLg5TntrrSAhVrCMAKHbr7BVQQ_AUICCgB',
  station: 'bank',
  contact: '020 7600 5216',
  website: 'http://www.davy.co.uk/wine-bar/davys-at-woolgate/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn24.save!

Venue.delete_all
vn25 = Venue.new(
  venuename: 'the sterling bar at the gherkin', 
  address: '30 saint mary axe',
  postcode: 'EC3A 8BF',
  maplink: 'https://www.google.co.uk/maps?q=the+sterling+bar+at+the+gherkin+30+st+mary+axe+EC3A+8BF&um=1&ie=UTF-8&sa=X&ved=0ahUKEwjHh-yPt7rSAhWlHsAKHXy-A3QQ_AUICCgB',
  station: 'aldgate',
  contact: '020 7929 3641',
  website: 'http://www.thesterlingbar.co.uk/',
  category_country_id: cc01.id,
  city: 'london'
  )
vn25.save!




