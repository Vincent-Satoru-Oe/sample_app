class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user

  	validates :user_id, presence: true
  	validates :content, presence: true, length: {maximum: 1400}

  	default_scope order: 'microposts.created_at DESC' #the .created_at attribute in descending order

  	def self.from_users_followed_by(user)
  		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  				#don't know how this gets the followed posts...
  	end

end