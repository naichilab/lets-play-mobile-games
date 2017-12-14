# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot'
Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f}

# create categories
categories = %w(シューティング アクション アドベンチャー ロールプレイング パズル レース シミュレーション 音楽 その他)
categories.each do |c|
  unless Category.where(name: c).any?
    FactoryBot.create(:category, name: c)
  end
end

# create platforms
platforms = {windows: 'Windows', osx: 'OS X', ios: 'iOS', android: 'Android', linux: 'Linux', web: 'Web'}
platforms.each do |code, name|
  unless Platform.where(code: code).any?
    FactoryBot.create(:platform, code: code, name: name)
  end
end

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

  categories = Category.all

  50.times do |n|
    game = FactoryBot.create(:game,
                             user: users.sample(1).first,
                             category: categories.sample(1).first)
    # pp game
  end

end