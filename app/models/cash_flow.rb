class CashFlow < ActiveRecord::Base
	belongs_to :cash_flowable, polymorphic: true
end
