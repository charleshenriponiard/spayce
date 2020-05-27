class ChangeTypeCodeApe < ActiveRecord::Migration[6.0]
  def change
    change_column :companies, :code_ape, :string
  end
end
