class AddScheduleIdToLecture < ActiveRecord::Migration
  def change
    add_column :lectures, :schedule_id, :integer
		add_index :lectures, [:schedule_id, :date], unique: true
  end
end
