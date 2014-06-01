namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		
		ATTENDANCE_ODDS = 5

		admin = User.create!(name: "admin",
												 email: "admin@kaist.ac.kr",
												 password: "admin",
												 password_confirmation: "admin",
												 admin: true)

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@kaist.ac.kr"
			password = "password"
			student_number = 2008000 + n
			User.create!(name: name,
									 email: email,
										student_number: student_number,
											password: password,
											password_confirmation: password)
		end

		courses = [
			{code: "CS408", name: "Computer Science Project", instructor: "Donsoo Han, Hojin Choi, Hyenseung Yang", 
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 10, 30), end_time:Time.new(2000, 1, 1, 12, 00)},
									{day:3, start_time:Time.new(2000, 1, 1, 10, 30), end_time:Time.new(2000, 1, 1, 12, 00)}]},
			{code: "CS341", name: "Introduction to Computer Network", instructor: "Suebok Moon",
			schedules_attributes: [{day:2, start_time:Time.new(2000, 1, 1, 9, 00), end_time:Time.new(2000, 1, 1, 10, 30)},
									{day:4, start_time:Time.new(2000, 1, 1, 9, 00), end_time:Time.new(2000, 1, 1, 10, 30)}]},
			{code: "MAS350", name: "Elementary Probability Theory", instructor: "Kangwook Hwang",
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 13, 00), end_time:Time.new(2000, 1, 1, 14, 30)},
									{day:3, start_time:Time.new(2000, 1, 1, 13, 00), end_time:Time.new(2000, 1, 1, 14, 30)}]},
			{code: "IS511", name: "Information Security", instructor: "Yongdae Kim, Seungwon Shin, Byunghoon Kang, Kyungsoo Park",
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 16, 00), end_time:Time.new(2000, 1, 1, 17, 30)},
									{day:3, start_time:Time.new(2000, 1, 1, 16, 00), end_time:Time.new(2000, 1, 1, 17, 30)}]}]

		courses.each do |course|
			Course.create!(course)
		end

		Course.all.each do |course|
			today = Date.current
			start = Date.new(today.year, today.month - 2, 30)

			while today > start do
				schedule = course.schedule_by_wday(start.wday)
				if schedule != nil
					schedule.lectures.create!(date: start)
				end
				start = start.tomorrow
			end
		end

		users = User.students
		users.each do |user|
			Lecture.all.each do |lecture|
					user.attend(lecture) if rand(ATTENDANCE_ODDS) != 0
			end
		end
	end
end
