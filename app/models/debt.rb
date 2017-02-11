class Debt < ActiveRecord::Base
	belongs_to :debtable, polymorphic: true
	has_many :advices, as: :from, dependent: :destroy
	has_many :advices, as: :to, dependent: :destroy
end
