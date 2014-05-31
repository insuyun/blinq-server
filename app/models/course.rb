class Course < ActiveRecord::Base
	has_many :schedules
	accepts_nested_attributes_for :schedules, allow_destroy: true
	validates :name, presence: true
	validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :instructor, presence: true

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
end
