class Schedule < ActiveRecord::Base
	belongs_to :course
	has_many :lectures

	validates :start_time, presence: true
	validates :end_time, presence: true
end
