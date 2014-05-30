class Course < ActiveRecord::Base
	has_many :schedules
	accepts_nested_attributes_for :schedules, allow_destroy: true
	validates :name, presence: true
	validates :code, presence: true, uniqueness: { case_sensitive: false }
	validates :instructor, presence: true
end
