class CreateSurveys < ActiveRecord::Migration[8.1]
  def change
    create_table :surveys do |t|
      t.integer :user_id

      t.timestamps
    end

    remove_column :answers, :user_id, :integer
  end
end
