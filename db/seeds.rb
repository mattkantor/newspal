# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.destroy_all
AdminUser.create!(email: 'matthewkantor@gmail.com', password: 'Shihonage3!', password_confirmation: 'Shihonage3!') if Rails.env.development?
AdminUser.create!(email: 'matthewkantor@gmail.com', password: 'Shihonage3!', password_confirmation: 'Shihonage3!') if Rails.env.production?
Source.destroy_all
require_relative "seeds_sources"
Source.clear_and_get
