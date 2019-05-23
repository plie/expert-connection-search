class CreateHeadings < ActiveRecord::Migration[5.2]
  def change
    create_table :headings do |t|
      t.belongs_to :user, index: true
      t.string :topics

      t.timestamps
    end
  end
end
