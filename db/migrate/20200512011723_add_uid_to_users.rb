class AddUidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :integer
    add_index :users, :uid, unique: true
  end
end
