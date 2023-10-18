class CreateLectures < ActiveRecord::Migration[7.1]
  def change
    create_table :lectures do |t|
      t.string :name, null: false
      t.integer :duration, null: false
      t.references :conference
      t.references :track
      t.time :starts_at
      t.time :ends_at

      t.timestamps
    end
  end
end
