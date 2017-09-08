function Investment(props){
	return(
		<div className="itemContainer">
			<div className="account__name__type">
				<div className="account__name">
					{props.name}
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

Investment.propTypes = {
	name: React.PropTypes.string,
	minimumMonthlyPayment: React.PropTypes.number,
	interestRate: React.PropTypes.number,
	amount: React.PropTypes.number
}
