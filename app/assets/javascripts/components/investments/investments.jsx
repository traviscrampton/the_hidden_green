function Investments(props){
	return(
		<div>
			<AddFinance financeType="Investment" />
			<div>
				{props.investmentsCollection.map(function(investment, index){
						return <Investment
							key={investment.id}
							name={investment.name}
							amount={investment.amount}
							interestRate={investment.interest_rate}   />
				})}
			</div>
		</div>
	)
}

Investments.PropTypes = {
	investmentsCollection: React.PropTypes.arrayOf(React.PropTypes.shape({
		name: React.PropTypes.string.isRequired,
		amount: React.PropTypes.number.isRequired,
		interest_rate: React.PropTypes.number.isRequired
	}))
}
