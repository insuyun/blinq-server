class Lecture < ActiveRecord::Base
	belongs_to :schedule
	validates :schedule_id, presence: true
	validates :date, presence: true
	validates_uniqueness_of :date, scope: :schedule_id

	def course
		schedule.course
	end
end
