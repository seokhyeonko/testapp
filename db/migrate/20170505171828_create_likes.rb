class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.text:pro_name
      t.integer:like
      t.integer:view_count

      t.timestamps null: false
    end
  end
end
