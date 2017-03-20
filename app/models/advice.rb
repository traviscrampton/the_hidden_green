class Advice < ActiveRecord::Base
	belongs_to :adviceable, polymorphic: true
	belongs_to :to, polymorphic: true
	belongs_to :from, polymorphic: true

	def from_what
		if from.class.name == "CashFlow"
			"CashFlow"
		else
			from.name + " " + from.class.name
		end
	end
end
