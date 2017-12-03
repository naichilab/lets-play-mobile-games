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

  # test user
  test_user = FactoryBot.build(:user, email: 'test@test.com', password: 'hogehoge')
  test_user.skip_confirmation!
  test_user.save

  # admin user
  admin_user = FactoryBot.build(:admin_user, email: 'admin@test.com', password: 'hogehoge')
  admin_user.skip_confirmation!
  admin_user.save

  3.times do |n|
    user = FactoryBot.build(:user)
    user.skip_confirmation!
    user.save
  end

  users = User.all

  5.times do |n|
    game = FactoryBot.create(:game, user: users.sample(1).first)
  end

end