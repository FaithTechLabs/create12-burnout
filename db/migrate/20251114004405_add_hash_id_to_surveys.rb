class AddHashIdToSurveys < ActiveRecord::Migration[8.1]
  def change
    add_column :surveys, :hash_id, :string
    add_index :surveys, :hash_id, unique: true
  end
end
