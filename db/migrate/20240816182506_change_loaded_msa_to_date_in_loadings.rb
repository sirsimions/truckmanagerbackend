class ChangeLoadedMsaToDateInLoadings < ActiveRecord::Migration[6.1]
  def up
    change_column :loadings, :loaded_msa, 'date USING CAST(loaded_msa AS date)'
  end

  def down
    change_column :loadings, :loaded_msa, :string
  end
end
