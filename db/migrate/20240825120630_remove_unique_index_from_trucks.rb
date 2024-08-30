class RemoveUniqueIndexFromTrucks < ActiveRecord::Migration[6.1]
  def change

    remove_index :trucks, :truck if index_exists?(:trucks, :truck)
    add_index :trucks, :truck

  end
end
