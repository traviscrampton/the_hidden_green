function Finance(props){
	return(
		<div className="itemContainer">
			<div className="account__name__type">
				<div className="account__name">
					{props.name}
				</div>
					<div className="account__type">
						Minimum Monthly Payment: {props.minumumMonthlyPayment}
					</div>
				<div className="account__type">
					Interest Rate: {props.interestRate}
				</div>
			</div>
			<div className="account__amount">
				{props.amount}
			</div>
		</div>
	)
}

Finance.propTypes = {
	name: React.PropTypes.string,
	minimumMonthlyPayment: React.PropTypes.number,
	interestRate: React.PropTypes.number,
	amount: React.PropTypes.number
}
