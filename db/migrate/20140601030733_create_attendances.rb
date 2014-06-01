class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :lecture_id
      t.integer :user_id

      t.timestamps
    end
		add_index :attendances, :user_id
		add_index :attendances, :lecture_id
		add_index :attendances, [:lecture_id, :user_id], unique: true
	end
end
