class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :siret
      t.string :name
      t.string :legal_structure
      t.integer :code_ape
      t.float :vat
      t.string :street_number
      t.string :street
      t.integer :zip_code
      t.string :city
      t.string :country
      t.date :start_activity

      t.timestamps
    end
  end
end
