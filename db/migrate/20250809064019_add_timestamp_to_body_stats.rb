class AddTimestampToBodyStats < ActiveRecord::Migration[7.1]
  def change
    add_column :body_stats, :timestamp, :date
  end
end
