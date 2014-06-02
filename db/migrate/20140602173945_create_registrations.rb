class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
		add_index :registrations, :user_id
		add_index :registrations, :course_id
		add_index :registrations, [:course_id, :user_id], unique: true
  end
end
