class Advice < ActiveRecord::Base
	belongs_to :adviceable, polymorphic: true
	belongs_to :to, polymorphic: true
	belongs_to :from, polymorphic: true

	before_create :round_to_two
	before_update :round_to_two

	def from_what
		if from.class.name == "CashFlow"
			"CashFlow"
		else
			from.name + " " + from.class.name
		end
	end

	def round_to_two
		self.amount = self.amount.round(2)
	end
end
