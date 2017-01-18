class Debt < ActiveRecord::Base
	belongs_to :debtable, polymorphic: true
end
