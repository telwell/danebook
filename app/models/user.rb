class User < ActiveRecord::Base


	# Let's add our associations

		has_one :profile, dependent: :destroy
		has_many :posts, :foreign_key => :author_id, dependent: :destroy
		has_many :likes, dependent: :destroy
		has_many :comments, :as => :commentable, :foreign_key => :author_id
		
		# Friending associations
		has_many :friendships
		has_many :friends, :through => :friendships
		has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => :friend_id
		has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	# End associations


	# And any filters will go here

		before_create :generate_token

	# End filters

	
	has_secure_password

	
	validates :password, 
						:length => { :in => 8..24 },
						:allow_nil => true

	validates :last_name, :email, :presence => true
	validates :gender, inclusion: { in: [1,2], message: "not selected" }

	def name
		first_name + ' ' + last_name
	end

	def friend_count
		self.friends.count
	end
	
	def generate_token
		begin
			self[:auth_token] = SecureRandom.urlsafe_base64
		end	while User.exists?(:auth_token => self[:auth_token])
	end


	def regenerate_auth_token
		self.auth_token = nil
		generate_token
		save!
	end


end
