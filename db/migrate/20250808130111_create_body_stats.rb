class CreateBodyStats < ActiveRecord::Migration[7.1]
  def change
    create_table :body_stats do |t|
      t.decimal :weight
      t.decimal :body_fat
      t.decimal :muscle_mass
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
