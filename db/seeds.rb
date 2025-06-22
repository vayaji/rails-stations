# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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