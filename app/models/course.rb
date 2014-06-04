class Course < ActiveRecord::Base
	has_many :schedules, :inverse_of => :course
	accepts_nested_attributes_for :schedules, allow_destroy: true
	validates :name, presence: true
	validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :instructor, presence: true

	has_many :registrations
	has_many :registering_users, through: :registrations, source: :user

	def schedule_by_wday wday
		schedules.to_a.find { |x| x.day == wday }
	end

	def lectures
		list_of_lectures = []	
		schedules.each do |schedule|
			list_of_lectures += schedule.lectures
		end

		list_of_lectures.sort{|x,y| x <=> y}
	end

	def registering_students
		registering_users.find_all{|user| not user.admin?}
	end
end
