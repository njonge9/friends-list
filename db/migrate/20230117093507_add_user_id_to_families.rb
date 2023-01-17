class AddUserIdToFamilies < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :user_id, :integer
    add_index :families, :user_id
  end
end
