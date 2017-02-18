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

# Venue.delete_all
# vn09 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn09.save!

# Venue.delete_all
# vn10 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn10.save!

# Venue.delete_all
# vn11 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn11.save!

# Venue.delete_all
# vn12 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn12.save!

# Venue.delete_all
# vn13 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn13.save!

# Venue.delete_all
# vn14 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn14.save!

# Venue.delete_all
# vn15 = Venue.new(
#   venuename: 'content', 
#   address: 'content',
#   postcode: 'content',
#   maplink: 'content',
#   station: 'content',
#   contact: 'content',
#   website: 'content',
#   category_country_id: cc01.id,
#   city: 'london'
#   )
# vn15.save!





