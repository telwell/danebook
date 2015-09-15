class Photo < ActiveRecord::Base
	# Adding our paperclip associations
	has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "200x200#" }
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	# Begin Associations
		belongs_to :user
		has_many :comments, :as => :commentable, :dependent => :destroy
	# End associations

	# Including concerns for likeable model
	include Likeable

	# So we can upload a photo via URL
	def photo_from_url(url)
	  self.photo = URI.parse(url)
	end
end
