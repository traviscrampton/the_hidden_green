class Advice < ActiveRecord::Base
	belongs_to :adviceable, polymorphic: true
end
