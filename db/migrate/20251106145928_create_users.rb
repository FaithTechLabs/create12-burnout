class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :accountability_email
      t.boolean :is_married
      t.boolean :has_children
      t.date :birthday
      t.integer :church_size

      t.timestamps
    end
  end
end
