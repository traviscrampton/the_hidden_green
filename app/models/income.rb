class Income < ActiveRecord::Base
	belongs_to :incomeable, polymorphic: true

	before_create :round_to_two
	before_update :round_to_two

	def round_to_two
		self.source_amount = self.source_amount.round(2)
	end
end
