function Debts(props){
	return(
		<div>
			<AddFinance financeType="Debt" />
			<div>
				{props.debtsCollection.map(function(debt, index){
						return <Debt
							key={debt.id}
							name={debt.name}
							amount={debt.amount}
							interestRate={debt.interest_rate} minimumMonthlyPayment={debt.minimum_monthly_payment}  />
				})}
			</div>
		</div>
	)
}

Debts.PropTypes = {
	debtsCollection: React.PropTypes.arrayOf(React.PropTypes.shape({
		name: React.PropTypes.string.isRequired,
		amount: React.PropTypes.number.isRequired,
		minimum_monthly_payment: React.PropTypes.number.isRequired,
		interest_rate: React.PropTypes.number.isRequired
	}))
}
