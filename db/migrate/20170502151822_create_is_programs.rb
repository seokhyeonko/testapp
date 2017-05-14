class CreateIsPrograms < ActiveRecord::Migration
  def change
    create_table :is_programs do |t|
      t.text :pro_name
      t.text :date
      t.timestamps null: false
    end
  end
end
