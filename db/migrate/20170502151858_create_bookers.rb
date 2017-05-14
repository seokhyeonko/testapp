class CreateBookers < ActiveRecord::Migration
  def change
    create_table :bookers do |t|
      t.text :name
      t.text :tel
      t.text :email
      t.text :date
      t.text :pro_name
      t.integer :count
      t.timestamps null: false
    end
  end
end
