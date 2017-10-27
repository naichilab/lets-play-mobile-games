module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(html_title = '')
    base_title = "そのゲーム、実況できる？ - 実況OKスマホゲーム一覧"
    if html_title.empty?
      base_title
    else
      html_title + " | " + base_title
    end
  end

end
