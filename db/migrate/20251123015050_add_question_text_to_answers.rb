class AddQuestionTextToAnswers < ActiveRecord::Migration[8.1]
  def change
    add_column :answers, :question_text, :string
  end
end
