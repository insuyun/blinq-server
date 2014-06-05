class AddAttendanceKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attendance_key, :string
  end
end
