class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.date :date

      t.timestamps
    end
  end
end
