class RemoveJsonOutputFromQuestions < ActiveRecord::Migration[7.1]
  def change
    remove_column :questions, :json_output, :string
  end
end
