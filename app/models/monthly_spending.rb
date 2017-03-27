class MonthlySpending < ActiveRecord::Base
	belongs_to :monthly_spendable, polymorphic: true

	before_create :nil_equal_to_zero

	def nil_equal_to_zero
		self.attributes.each do |key, value|
			next if key == "id"
			self.attributes[key] = 0 if value == nil
		end
	end
end
