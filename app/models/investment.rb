class Investment < ActiveRecord::Base
	belongs_to :investmentable, polymorphic: true
	has_many :advices, as: :from, dependent: :destroy
	has_many :advices, as: :to, dependent: :destroy
end
