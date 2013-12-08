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

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    post = find_by_id(row["id"]) || new
	    post.attributes = row.to_hash #.slice(*accessible_attributes)
	    post.save!
	  end
	end

  def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
  end
end
