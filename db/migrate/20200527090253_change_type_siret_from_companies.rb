class ChangeTypeSiretFromCompanies < ActiveRecord::Migration[6.0]
    def up
      change_column :companies, :siret, :bigint, :limit => 14
    end

    def down
      change_column :companies, :siret, :integer
    end
end
