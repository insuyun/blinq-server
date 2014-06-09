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

	has_many :children, class_name: :User, foreign_key: :parent_id
	belongs_to :parent, class_name: :User, foreign_key: :parent_id
	belongs_to :attending_lecture, class_name: :Lecture, foreign_key: :lecture_id

	def start_check (course)
		if admin?
			course.registering_users.update_all({ parent_id: nil, lecture_id: nil })
			update_attribute(:lecture_id, course.lectures.last.id)
		end
	end

	def stop_check (course)
		if admin?
			course.registering_users.update_all({ parent_id: nil, lecture_id: nil })
		end
	end

	def checking?
			not attending_lecture.nil?
	end

	def attending?(lecture)
			attendances.find_by(lecture_id: lecture.id)
	end

	def attend(lecture)
		if registered_courses.include? lecture.course
			attendances.create!(lecture_id: lecture.id)
			attending_lecture = lecture
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

	def root
		curr = self.parent
		prev = nil

		while not curr.nil?
			prev = curr
			curr = curr.parent
		end

		prev ||= self
	end

	def union other_user
		neighbor_root = root
		current_root = other_user.root

		# already same tree
		return if current_root == neighbor_root
		
		admin_root, no_admin_root = neighbor_root, current_root

		if neighbor_root.admin? or current_root.admin?
			no_admin_root, admin_root = neighbor_root, current_root if current_root.admin? and not neighbor_root.admin?
			no_admin_root.update_attribute(:parent_id, admin_root.id)

			lecture = admin_root.attending_lecture
			processed_list = []
			non_processed_list = [no_admin_root]
			
			while not non_processed_list.empty?
				user = non_processed_list.pop
				processed_list << user
				non_processed_list += user.children
			end

			while not processed_list.empty?
				user = processed_list.pop
				if not user.attending? lecture
					user.attend lecture
					user.push_message ("#{lecture.course.name} checked!!")
					admin_root.push_message("#{user.name} in #{lecture.course.name} checked!!")
				end
			end

		end
	end

	def push_message msg
		apn = Houston::Client.development
		apn.certificate = File.read(File.join(Rails.root, 'app', 'certs', 'cert_ios_production.pem'))
		apn.passphrase = 'blinq'
		# An example of the token sent back when a device registers for notifications

		# Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
		notification = Houston::Notification.new(device: push_token)
		notification.alert = msg

		# Notifications can also change the badge count, have a custom sound, indicate available Newsstand content, or pass along arbitrary data.
		notification.badge = 57
		notification.sound = "sosumi.aiff"

		# And... sent! That's all it takes.
		apn.push(notification)
	end

	private
	def create_attendance_key
		begin
			self. attendance_key = SecureRandom.hex(4) # or whatever you chose like UUID tools
		end while self.class.exists?(:attendance_key => attendance_key)
	end

	handle_asynchronously :push_message
end
