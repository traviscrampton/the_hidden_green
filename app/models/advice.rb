class Advice < ActiveRecord::Base
	belongs_to :adviceable, polymorphic: true
	belongs_to :to, polymorphic: true
	belongs_to :from, polymorphic: true
end
