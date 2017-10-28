# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if ENV['VIRTUAL_ENV'] == 'development'
  require 'factory_bot'
  Dir[Rails.root.join('spec/support/factories/*.rb')].each { |f| require f }
end


if ENV['VIRTUAL_ENV'] == 'development'

  10.times do |n|
    FactoryBot.create(:user)
  end

  users = User.all

  50.times do |n|
    game = FactoryBot.create(:game, user: users.sample(1).first)
  end

end