class CreateTrucks < ActiveRecord::Migration[6.1]
  def change
    create_table :trucks do |t|
      t.string :truck
      t.string :customer
      t.string :product
      t.string :depot
      t.string :route_name
      t.date :date_loaded
      t.string :mode
      t.string :loaded_status
      t.string :location
      t.date :status_date
      t.time :status_time
      t.string :status
      t.text :remarks
      t.float :distance_covered
      t.string :region
      t.string :country

      t.timestamps
    end
  end
end
