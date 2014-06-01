class User < ActiveRecord::Base
	has_secure_password

	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_many :attendances
	has_many :attended_lectures, through: :attendances, source: :lecture

	def attending?(lecture)
		attendances.find_by(lecture_id: lecture.id)
	end

	def attend(lecture)
		attendances.create!(lecture_id: lecture.id)
	end

	def self.students
		all.find_all {|user| not user.admin?}
	end
end
