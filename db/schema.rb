# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_06_25_022952) do
  create_table "movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 160, null: false, comment: "映画のタイトル。邦題・洋題は一旦考えなくてOK"
    t.string "year", limit: 45, comment: "公開年"
    t.text "description", comment: "映画の説明文"
    t.string "image_url", limit: 150, comment: "映画のポスター画像が格納されているURL"
    t.boolean "is_showing", null: false, comment: "上映中かどうか"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movies_on_name"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.datetime "start_time", null: false, comment: "上映開始時間"
    t.datetime "end_time", null: false, comment: "上映終了時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_schedules_on_movie_id"
  end

  create_table "sheets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "column", limit: 1, null: false
    t.string "row", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "schedules", "movies"
end
