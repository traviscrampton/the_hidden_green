class CashFlow < ActiveRecord::Base
	belongs_to :cash_flowable, polymorphic: true
	has_many :advices, as: :from, dependent: :destroy
end
