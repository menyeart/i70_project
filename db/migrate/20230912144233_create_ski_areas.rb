class CreateSkiAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :ski_areas do |t|
      t.string :name
      t.string :location_id

      t.timestamps
    end
  end
end
