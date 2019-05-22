class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :friended_user, index: true
      
      t.timestamps
    end

    add_foreign_key :friends, :users, column: :friended_user_id
    add_index :friends, [:user_id, :friended_user_id], unique: true
  end
end
