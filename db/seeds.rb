# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot'
Dir[Rails.root.join('spec/support/factories/*.rb')].each { |f| require f }

FactoryBot.create(:category, name: 'シューティング')
FactoryBot.create(:category, name: 'アクション')
FactoryBot.create(:category, name: 'アドベンチャー')
FactoryBot.create(:category, name: 'ロールプレイング')
FactoryBot.create(:category, name: 'パズル')
FactoryBot.create(:category, name: 'レース')
FactoryBot.create(:category, name: 'シミュレーション')
FactoryBot.create(:category, name: '音楽')
FactoryBot.create(:category, name: 'その他')

if ENV['VIRTUAL_ENV'] == 'development'

  10.times do |n|
    FactoryBot.create(:user)
  end

  users = User.all

  50.times do |n|
    game = FactoryBot.create(:game, user: users.sample(1).first)
  end

end