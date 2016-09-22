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


CategoryTopic.delete_all
ct01 = CategoryTopic.create!(name:'Auto, Boat & Air')
ct02 = CategoryTopic.create!(name:'Business Professional')
ct03 = CategoryTopic.create!(name:'Charity & Causes')
ct04 = CategoryTopic.create!(name:'Community & Culture')
ct05 = CategoryTopic.create!(name:'Family & Education')
ct06 = CategoryTopic.create!(name:'Fashion & Beauty')
ct07 = CategoryTopic.create!(name:'Film, Media & Entertainment')
ct08 = CategoryTopic.create!(name:'Food & Drink')
ct09 = CategoryTopic.create!(name:'Fundraising')
ct10 = CategoryTopic.create!(name:'Government & Politics')
ct11 = CategoryTopic.create!(name:'Health & Wellness')
ct12 = CategoryTopic.create!(name:'Hobbies & Special Interest')
ct13 = CategoryTopic.create!(name:'Home & Lifestyle')
ct14 = CategoryTopic.create!(name:'Music')
ct15 = CategoryTopic.create!(name:'Performing & Visual Arts')
ct16 = CategoryTopic.create!(name:'Religion & Spirituality')
ct17 = CategoryTopic.create!(name:'Science & Technology')
ct18 = CategoryTopic.create!(name:'Social Impact')
ct19 = CategoryTopic.create!(name:'Sports & Fitness')
ct20 = CategoryTopic.create!(name:'Travel & Outdoors')
ct21 = CategoryTopic.create!(name:'Tech Stories')
ct22 = CategoryTopic.create!(name:'Other')