class Investment < ActiveRecord::Base
	belongs_to :investmentable, polymorphic: true
	has_many :advices, as: :from, dependent: :destroy
	has_many :advices, as: :to, dependent: :destroy

	before_create :round_to_two
	before_update :round_to_two

	def round_to_two
		self.amount = self.amount.round(2)
	end
end
