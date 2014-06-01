class Lecture < ActiveRecord::Base
	belongs_to :schedule
	validates :schedule_id, presence: true
	validates :date, presence: true
	validates_uniqueness_of :date, scope: :schedule_id

	has_many :attendances
	has_many :attending_users, through: :attendances, source: :user

	def course
		schedule.course
	end
end
