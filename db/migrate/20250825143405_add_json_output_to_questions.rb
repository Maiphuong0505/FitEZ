class AddJsonOutputToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :json_output, :string
  end
end
