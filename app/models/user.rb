class User < ActiveRecord::Base
	before_create :create_attendance_key
	has_secure_password

	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_many :attendances
	has_many :attended_lectures, through: :attendances, source: :lecture
	
	has_many :registrations
	has_many :registered_courses, through: :registrations, source: :course

	def attending?(lecture)
			attendances.find_by(lecture_id: lecture.id)
	end

	def attend(lecture)
		if registered_courses.include? lecture.course
			attendances.create!(lecture_id: lecture.id)
		end
	end

	def register(course)
		registrations.create!(course_id: course.id)
	end

	def unregistered_courses
			Course.all - registered_courses 
	end

	def self.students
		all.find_all {|user| not user.admin?}
	end

	def attend_last_lecture?(course)
		attending? course.lectures.last
	end

	private
	def create_attendance_key
		begin
			self. attendance_key = SecureRandom.hex(8) # or whatever you chose like UUID tools
		end while self.class.exists?(:attendance_key => attendance_key)
	end
end
