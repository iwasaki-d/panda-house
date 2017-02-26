class CreateNearestStations < ActiveRecord::Migration[5.0]
  def change
    create_table :nearest_stations do |t|
      t.references :house, index: true
      t.string :line_name, null: false
      t.string :station_name, null:false
      t.integer :minutes_walk, null:false

      t.timestamps
    end
  end
end
