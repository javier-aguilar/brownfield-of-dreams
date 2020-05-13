class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string, :default => 'inactive'
    add_column :users, :confirm_token, :string
  end
end
