class ChangeNameColumneFromInvoices < ActiveRecord::Migration[6.0]
  def change
    rename_column :invoices, :desciption, :description
  end
end
