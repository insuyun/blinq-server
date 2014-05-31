namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do

		Course.all.each do |course|
			today = Date.current
			start = Date.new(today.year, today.month - 2, 30)

			while today > start do
				schedule = course.schedule_by_wday(start.wday)
				if schedule != nil
					schedule.lectures.create(date: start)
				end
				start = start.tomorrow
			end
		end
	end
end
