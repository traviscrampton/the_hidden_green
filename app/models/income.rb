class Income < ActiveRecord::Base
	belongs_to :incomeable, polymorphic: true
end
