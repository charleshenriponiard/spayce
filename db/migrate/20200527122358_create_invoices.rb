class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.text :desciption
      t.string :file
      t.float :amount
      t.string :ref_number
      t.date :end_date
      t.integer :status
      t.string :code_promo

      t.timestamps
    end
  end
end
