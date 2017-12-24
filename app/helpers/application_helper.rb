module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(html_title = '')
    base_title = "ゲームを実況しよう！ - 実況OKなゲームを集めました"
    if html_title.empty?
      base_title
    else
      html_title + " | " + base_title
    end
  end

  def text_contain_url(text)
      URI.extract(text, ['http', 'https']).uniq.each do |url|
          sub_text = "" << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
          text.gsub!(url, sub_text)
      end
      return text
  end
end
