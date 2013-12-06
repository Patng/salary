class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :company, presence: true
	validates :salary, presence: true
	validates :location_id, presence: true

	belongs_to :location

def self.search(title, company, location_id)
    if location_id.present?

        paginate :conditions => ['title LIKE ? AND company LIKE ? AND location_id = ?', "%#{title}%", "%#{company}%", location_id],
                        :per_page => 20,
                        :order => 'created_at DESC',
                        :page => @page,
                        :total_entries => 200

    else

        paginate :conditions => ['title LIKE ? AND company LIKE ?', "%#{title}%", "%#{company}%"],
                        :per_page => 20,
                        :order => 'created_at DESC',
                        :page => @page,
                        :total_entries => 200               
    end
end
end
