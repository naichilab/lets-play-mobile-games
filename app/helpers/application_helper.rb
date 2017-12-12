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

end
