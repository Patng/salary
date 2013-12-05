class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :company, presence: true
	validates :salary, presence: true
	validates :country, presence: true
end
