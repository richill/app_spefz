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

CategoryCountry.delete_all
cc01 = CategoryCountry.create!(name:'United Kingdom')
cc02 = CategoryCountry.create!(name:'United States')
cc03 = CategoryCountry.create!(name:'Ghana')
cc04 = CategoryCountry.create!(name:'Nigeria')

CategoryInvite.delete_all
ci01 = CategoryInvite.create!(name:'just my guest')
ci02 = CategoryInvite.create!(name:'open to everyone')

CategoryQuantitygender.delete_all
cqg01 = CategoryQuantitygender.create!(name:'only men')
cqg02 = CategoryQuantitygender.create!(name:'only women')
cqg03 = CategoryQuantitygender.create!(name:'both men & women')
cqg04 = CategoryQuantitygender.create!(name:'both X men & X women')

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













