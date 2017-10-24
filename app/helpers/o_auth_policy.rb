module OAuthPolicy
  class Base
    attr_reader :provider, :uid, :name, :nickname, :email, :url, :image_url,
                :description, :other, :credentials, :raw_info
  end

  class Twitter < OAuthPolicy::Base
    def initialize(auth)
      @provider    = auth["provider"]
      @uid         = auth["uid"]
      @name        = auth["info"]["name"]
      @nickname    = auth["info"]["nickname"]
      @email       = auth["info"]["email"]
      @url         = auth["info"]["urls"]["Twitter"]
      @image_url   = auth["info"]["image"].gsub(/_normal/,"") #_400x400
      @description = auth["info"]["description"].try(:truncate, 255)
      @credentials = auth["credentials"].to_json
      @raw_info    = auth["extra"]["raw_info"].to_json
      freeze
    end
  end


  class Facebook < OAuthPolicy::Base
    def initialize(auth)
      @provider    = auth.provider
      @uid         = auth.uid
      @name        = auth.info.name
      @nickname    = ""
      @email       = auth.extra.raw_info.email
      @url         = "https://www.facebook.com/" + auth.uid
      @image_url   = auth.info.image + "?width=512&height=512"
      @description = ""
      @credentials = auth.credentials.to_json
      @raw_info    = auth.extra.raw_info.to_json
      freeze
    end
  end

  class Github < OAuthPolicy::Base
    def initialize(auth)
      @provider    = auth.provider
      @uid         = auth.uid
      @name        = auth.info.name
      @nickname    = auth.info.nickname
      @email       = auth.info.email
      @url         = auth.info.urls.Blog.present? ? auth.info.urls.Blog : auth.info.urls.GitHub
      @image_url   = auth.info.image
      @description = ""
      @credentials = auth.credentials.to_json
      @raw_info    = auth.extra.raw_info.to_json
      freeze
    end
  end

end