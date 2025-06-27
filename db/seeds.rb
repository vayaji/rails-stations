# ==== Movies ====
movies = [
  {
    name: "君の名は。",
    year: "2016",
    description: "東京と田舎の高校生が夢の中で入れ替わる、不思議な青春ラブストーリー。",
    image_url: "https://www.themoviedb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg",
    is_showing: true
  },
  {
    name: "インセプション",
    year: "2010",
    description: "夢の中の夢へと潜入する、SFサスペンスアクション。",
    image_url: "https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg",
    is_showing: false
  },
  {
    name: "スパイダーマン: ノー・ウェイ・ホーム",
    year: "2021",
    description: "複数のスパイダーマンが集うマルチバースアクション。",
    image_url: "https://image.tmdb.org/t/p/w500/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
    is_showing: true
  }
]

movies.each do |movie_attrs|
  Movie.find_or_create_by!(name: movie_attrs[:name]) do |movie|
    movie.assign_attributes(movie_attrs)
  end
end

puts "🎬 Movies seeding completed (#{movies.size} movies)"

# ==== Sheets ====
rows = %w[a b c]
columns = (1..5)

rows.each do |row|
  columns.each do |col|
    Sheet.find_or_create_by!(row: row, column: col)
  end
end

puts "✔️ Sheets seeding completed (#{rows.size * columns.size} sheets)"

# ==== Schedules ====

# 各映画の上映時間（分）
movie_durations = {
  "君の名は。" => 120,
  "スパイダーマン: ノー・ウェイ・ホーム" => 150,
  "インセプション" => 148
}

# 1日に3回上映する時間帯の開始時刻（例: 10:00, 14:00, 18:00）
show_start_times = [10, 14, 18]

Movie.find_each do |movie|
  duration_min = movie_durations[movie.name]
  unless duration_min
    puts "⚠️ 映画『#{movie.name}』の上映時間が不明です。"
    next
  end

  show_start_times.each do |hour|
    # 時刻だけのTimeオブジェクト（日付は適当に固定、例: 2000-01-01）
    start_time = Time.new(2000, 1, 1, hour, 0, 0)
    end_time = start_time + duration_min * 60 # 秒に変換して加算

    # DBのtime型カラムには時刻だけ入る想定なので、Timeオブジェクトをそのまま保存
    Schedule.find_or_create_by!(movie_id: movie.id, start_time: start_time) do |schedule|
      schedule.end_time = end_time
    end
  end
end

puts "🕒 各映画の上映スケジュール（時間のみ）を作成しました"
