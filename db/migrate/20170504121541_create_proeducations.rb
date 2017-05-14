class CreateProeducations < ActiveRecord::Migration
  def change
    create_table :proeducations do |t|
      t.text :pro_name
      t.text :pro_institute
      t.text :address
      t.text :ptype
      t.integer :limit_people
      t.text :tel
      t.text :period
      t.text :target
      t.text :content
      t.integer :like
      t.integer :count_view

      t.timestamps null: false
    end
  end
end
