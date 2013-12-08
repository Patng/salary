class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :company, presence: true
	validates :salary, presence: true
	validates :location_id, presence: true

	belongs_to :location

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |post|
				csv << post.attributes.values_at(*column_names)
			end
		end
	end
end
