class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
#		add_index :schedules, [:day, :start_time, :end_time], unqiue: true
  end
end
