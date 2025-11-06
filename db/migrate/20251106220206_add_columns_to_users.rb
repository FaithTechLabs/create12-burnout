class AddColumnsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :accountability_email, :string
    add_column :users, :is_married, :boolean
    add_column :users, :has_children, :boolean
    add_column :users, :birthday, :date
    add_column :users, :church_size, :integer
  end
end
