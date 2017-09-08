function Incomes(props){
	return(
		<div>
			<AddFinance financeType="Income" />
			<div>
				{props.incomesCollection.map(function(income, index){
						return <Income
							key={income.id}
							name={income.source_name}
							amount={income.source_amount} />
				})}
			</div>
		</div>
	)
}

Incomes.PropTypes = {
	incomesCollection: React.PropTypes.arrayOf(React.PropTypes.shape({
		source_name: React.PropTypes.string.isRequired,
		source_amount: React.PropTypes.number.isRequired,
	}))
}
