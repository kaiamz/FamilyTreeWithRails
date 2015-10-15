class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :mother_id, :int
      t.column :father_id, :int
    end
  end
end
