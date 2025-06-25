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

puts "✔️ Sheets seeding completed (#{rows.size * columns.size} seats)"

# ==== Schedules ====
schedule_data = [
  {
    movie_name: "君の名は。",
    start_time: DateTime.new(2025, 6, 30, 14, 0, 0),
    end_time: DateTime.new(2025, 6, 30, 16, 0, 0)
  },
  {
    movie_name: "スパイダーマン: ノー・ウェイ・ホーム",
    start_time: DateTime.new(2025, 6, 30, 17, 30, 0),
    end_time: DateTime.new(2025, 6, 30, 20, 0, 0)
  }
]

schedule_data.each do |data|
  movie = Movie.find_by(name: data[:movie_name])
  if movie
    Schedule.find_or_create_by!(movie_id: movie.id, start_time: data[:start_time]) do |schedule|
      schedule.end_time = data[:end_time]
    end
  else
    puts "⚠️ 映画『#{data[:movie_name]}』が見つかりませんでした。"
  end
end

puts "🕒 Schedules seeding completed (#{schedule_data.size} schedules)"
