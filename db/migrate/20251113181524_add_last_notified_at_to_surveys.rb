class AddLastNotifiedAtToSurveys < ActiveRecord::Migration[8.1]
  def change
    add_column :surveys, :last_notified_at, :timestamp
  end
end
