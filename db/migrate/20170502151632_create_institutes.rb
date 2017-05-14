class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.text :institute_id
      t.text :institute_pw
      t.text :institute_name
      t.timestamps null: false
    end
  end
end
