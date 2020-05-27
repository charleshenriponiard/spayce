class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
