class AddUserIdToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_column :tasks, :name, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
