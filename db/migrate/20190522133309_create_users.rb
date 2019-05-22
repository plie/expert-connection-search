class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :website
      t.string :slug, index: true
      t.string :head_one, array: true, default: []
      t.string :head_two, array: true, default: []
      t.string :head_three, array: true, default: []

      t.timestamps
    end
  end
end
