class Investment < ActiveRecord::Base
	belongs_to :investmentable, polymorphic: true
end
