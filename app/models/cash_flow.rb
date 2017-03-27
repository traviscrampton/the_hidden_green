class CashFlow < ActiveRecord::Base
	belongs_to :cash_flowable, polymorphic: true
	has_many :advices, as: :from, dependent: :destroy

	before_create :round_to_two
	before_update :round_to_two

	def round_to_two
		self.amount = self.amount.round(2)
	end
end
