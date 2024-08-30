class CreateLoadings < ActiveRecord::Migration[6.1]
  def change
    create_table :loadings do |t|
      t.string :truck
      t.string :trailer
      t.string :diff
      t.string :truckconfig
      t.string :truckreg
      t.string :msa_arvd_or_enroute
      t.string :customer
      t.string :loaded_msa
      t.date :disp_msa_date
      t.integer :days_in_msa
      t.string :final_destination
      t.date :date_offloaded
      t.string :current_truck_stat
      t.string :allocation_status
      t.string :allocated_clients
      t.text :workshop_comments
      t.decimal :proj_rev

      t.timestamps
    end
  end
end
