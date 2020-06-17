class AddMpUserIdToMangopayUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mp_user_id, :integer
  end
end
