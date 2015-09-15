class Photo < ActiveRecord::Base
	# Adding our paperclip associations
	has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "200x200#" }
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	belongs_to :user

	# So we can upload a photo via URL
	def photo_from_url(url)
	  self.photo = URI.parse(url)
	end
end
