class User < ActiveRecord::Base
  has_many :workouts
  has_many :movements
  has_secure_password #this links bcrypt with ActiveRecord

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
