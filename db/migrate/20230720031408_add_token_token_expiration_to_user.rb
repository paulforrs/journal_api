class AddTokenTokenExpirationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expiration, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
