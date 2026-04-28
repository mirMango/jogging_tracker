class CreateJogEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :jog_entries do |t|
      t.date :date
      t.float :distance
      t.integer :time
      t.float :average_speed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
