class Wage < ActiveRecord::Base

	validates :title, presence: true
	validates :company, presence: true
	validates :location_id, presence: true
	validates :total, presence: true
	validates :avg, presence: true
	validates :high, presence: true
	validates :low, presence: true

	belongs_to :location

  self.per_page = 10

  def self.search(title, company, location_id, page)

    if location_id.present?
      wages = Wage.where('title LIKE ? AND company LIKE ? AND location_id = ?', "%#{title}%", "%#{company}%", location_id).order('total DESC').limit(200).paginate(:page => page)
    else
      wages = Wage.where('title LIKE ? AND company LIKE ?', "%#{title}%", "%#{company}%").order('total DESC').limit(200).paginate(:page => page)
    end
    return wages
  end

    def self.import(file)
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            wage = find_by_id(row["id"]) || new
            wage.attributes = row.to_hash #.slice(:title, :company, :location_id, :total, :avg, :high, :low)
            wage.save!
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
