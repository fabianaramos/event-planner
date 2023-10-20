class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.references :conference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
