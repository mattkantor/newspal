# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.destroy_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Source.destroy_all

Source.create!(name:"CNN Top Stories", rss_url:"http://rss.cnn.com/rss/cnn_topstories.rss", logo_url:"http://i2.cdn.turner.com/cnn/2015/images/09/24/cnn.digital.png")
Source.create!(name:"The Hill", rss_url:"http://thehill.com/rss/syndicator/19109", logo_url:"http://thehill.com/sites/all/themes/thehill/images/redesign/thehill-logo-big.png")
Source.create!(name:"Reuters Top News", rss_url:"http://feeds.reuters.com/reuters/topNews", logo_url:"http://www.reuters.com/resources_v2/images/reuters125.png")
Source.create!(name:"Politico - Politics", rss_url:"http://www.politico.com/rss/politics08.xml", logo_url:"https://pmcvariety.files.wordpress.com/2016/05/politico-logo.jpg?w=913&h=513&crop=1")

Source.create!(name:"MSNBC - Top Headlines", rss_url:"http://rss.msnbc.msn.com/id/3032091/device/rss/rss.xml", logo_url:"")
Source.create!(name:"CNBC - Top News", rss_url:"https://www.cnbc.com/id/100003114/device/rss/rss.html", logo_url:"")
