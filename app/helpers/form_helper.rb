module FormHelper

	def which_type(index)
		if index == 0
			return "Savings"
		else
			return "Checkings"
		end
	end

end
