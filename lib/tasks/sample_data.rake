namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		
		ATTENDANCE_ODDS = 5

		admin = User.create!(name: "admin",
												 email: "admin@kaist.ac.kr",
												 password: "admin",
												 password_confirmation: "admin",
												 admin: true)

		user = User.create!(name: "user",
												student_number: 20080587,
												email: "user@kaist.ac.kr",
												password: "user",
												password_confirmation: "user")

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
			{code: "CS408", name: "Computer Science Project", instructor: "Donsoo Han, Hojin Choi, Hyenseung Yang", course_type:0, career:1, homepage: "klms.kaist.ac.kr", notice: "- Placement by professor during the course will be changed - Undergraduate, Graduate mutual recognition",
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 10, 30), end_time:Time.new(2000, 1, 1, 12, 00)},
									{day:3, start_time:Time.new(2000, 1, 1, 10, 30), end_time:Time.new(2000, 1, 1, 12, 00)}]},
			{code: "CS341", name: "Introduction to Computer Network", instructor: "Suebok Moon", course_type: 1, career: 0, homepage: "klms.kaist.ac.kr", notice: "",
			schedules_attributes: [{day:2, start_time:Time.new(2000, 1, 1, 9, 00), end_time:Time.new(2000, 1, 1, 10, 30)},
									{day:4, start_time:Time.new(2000, 1, 1, 9, 00), end_time:Time.new(2000, 1, 1, 10, 30)}]},
			{code: "MAS350", name: "Elementary Probability Theory", instructor: "Kangwook Hwang", course_type:1, career:0, homepage: "klms.kaist.ac.kr", notice: "blackboard",
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 13, 00), end_time:Time.new(2000, 1, 1, 14, 30)},
									{day:3, start_time:Time.new(2000, 1, 1, 13, 00), end_time:Time.new(2000, 1, 1, 14, 30)}]},
			{code: "IS511", name: "Information Security", instructor: "Yongdae Kim, Seungwon Shin, Byunghoon Kang, Kyungsoo Park", course_type:0, career:1, homepage: "http://syssec.kaist.ac.kr/~yongdaek/courses/is511/index.html", notice: "Undergraduate, Graduate mutual recongnition",
			schedules_attributes: [{day:1, start_time:Time.new(2000, 1, 1, 16, 00), end_time:Time.new(2000, 1, 1, 17, 30)},
									{day:3, start_time:Time.new(2000, 1, 1, 16, 00), end_time:Time.new(2000, 1, 1, 17, 30)}]},
			{code: "CS311", name: "Computer Architecture", instructor: "Hyeonsoo Yoon", course_type:0, career:0, homepage: "klms.kaist.ac.kr", notice: "", 
				schedules_attributes: [{day:2, start_time:Time.new(2000, 1, 1, 14, 30), end_time:Time.new(2000, 1, 1, 16, 00)},
									{day:4, start_time:Time.new(2000, 1, 1, 14, 30), end_time:Time.new(2000, 1, 1, 16, 00)}]}]

		courses.each do |course|
			p course
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

		users = User.all
		courses = Course.all[0..-2] # except for one course
		
		users.each do |user|
			courses.each do |course|
				user.register course
				course.lectures.each do |lecture|
					user.attend lecture if rand(ATTENDANCE_ODDS) != 0
				end
			end
		end
	end
end
