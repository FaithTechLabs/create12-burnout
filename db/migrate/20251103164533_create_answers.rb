class CreateAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :survey_id
      t.integer :answer

      t.timestamps
    end
  end
end
