class ChangeMsaArvdOrEnrouteToDateInLoadings < ActiveRecord::Migration[6.1]
  def up
    change_column :loadings, :msa_arvd_or_enroute, 'date USING CAST(msa_arvd_or_enroute AS date)'
  end

  def down
    change_column :loadings, :msa_arvd_or_enroute, :string
  end
end
