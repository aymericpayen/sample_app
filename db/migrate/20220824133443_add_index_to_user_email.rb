class AddIndexToUserEmail < ActiveRecord::Migration[6.1]
  #Adding index on column email to ensure unicityof emails in the database
  def change
    add_index :users, :email, unique: true
  end
end
