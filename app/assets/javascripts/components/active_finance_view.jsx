function ActiveFinanceView(props){
	return(
		this.chooseActiveFinance(props)
	)
}

function chooseActiveFinance(props){
	var optionsHash = {
		"None": <DefaultDash />,
		"Debts":<Debts debtsCollection={props.activeFinances}/>,
		"Investments": <Investments investmentsCollection={props.activeFinances} />
	}
	return optionsHash[props.activeFinance]
}

ActiveFinanceView.propTypes = {
	activeFinance: React.PropTypes.string,
	activeFinances: React.PropTypes.arrayOf(React.PropTypes.shape({
		name: React.PropTypes.string,
		amount: React.PropTypes.number,
		minimum_monthly_payment: React.PropTypes.number,
		interest_rate: React.PropTypes.number
	}))
}
