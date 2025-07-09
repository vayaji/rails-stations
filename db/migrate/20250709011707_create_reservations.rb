class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :date, null: false
      t.references :schedule, null: false, foreign_key: true, index: true
      t.references :sheet, null: false, foreign_key: true, index: true
      t.references :screen, null: false, foreign_key: true, index: true
      t.string :email, null: false, limit: 255, comment: '予約者メールアドレス'
      t.string :name, null: false, limit: 50, comment: '予約者名'

      t.timestamps
    end

    add_index :reservations, [:date, :schedule_id, :sheet_id, :screen_id], unique: true
  end
end
