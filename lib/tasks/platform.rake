namespace :platform do

  desc "公開URLデータの移行"
  task :convert => :environment do

    androidPlatform = Platform.find_by_code('android')
    iosPlatform = Platform.find_by_code('ios')

    Game.all.each do |g|

      if g.android_url.present?

        if StoreUrl
               .where(game_id: g.id)
               .where(platform_id: androidPlatform.id)
               .where(url: g.android_url)
               .any?
          pp '登録済み'
        else
          StoreUrl.create(game_id: g.id, platform_id: androidPlatform.id, url: g.android_url)
        end

      end

      if g.ios_url.present?

        if StoreUrl
               .where(game_id: g.id)
               .where(platform_id: iosPlatform.id)
               .where(url: g.ios_url)
               .any?
          pp '登録済み'
        else
          StoreUrl.create(game_id: g.id, platform_id: iosPlatform.id, url: g.ios_url)
        end

      end

    end


  end
end
