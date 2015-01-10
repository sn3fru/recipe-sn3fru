class Review < ActiveRecord::Base
	acts_as_mentioner
	belongs_to :recipe
	belongs_to :user
end
