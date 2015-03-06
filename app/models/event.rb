class Event < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :event_attendees
	has_many :users, through: :attendees
	validates :name, :date, :location, :state, :user_id, presence: true
end
