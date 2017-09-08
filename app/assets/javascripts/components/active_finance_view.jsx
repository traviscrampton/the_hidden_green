function ActiveFinanceView(props){
	return(
		this.chooseActiveFinance(props)
	)
}

function chooseActiveFinance(props){
	var optionsHash = {
		"None": <DefaultDash />,
		"Debt":<Debts debtsCollection={props.activeFinances}/>,
		"Investment": <Investments investmentsCollection={props.activeFinances} />,
		"Account": <Accounts accountsCollection={props.activeFinances}/>,
		"Income": <Incomes incomesCollection={props.activeFinances} />
	}
	return optionsHash[props.activeFinance]
}

ActiveFinanceView.propTypes = {
	activeFinance: React.PropTypes.string,
	activeFinances: React.PropTypes.arrayOf(React.PropTypes.shape({
		source_name: React.PropTypes.string,
		source_amount: React.PropTypes.number,
		name: React.PropTypes.string,
		amount: React.PropTypes.number,
		minimum_monthly_payment: React.PropTypes.number,
		interest_rate: React.PropTypes.number
	}))
}
