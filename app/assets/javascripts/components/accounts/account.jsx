function Account(props){
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
				$ {props.amount}
			</div>
		</div>
	)
}

Account.propTypes = {
	name: React.PropTypes.string,
	interestRate: React.PropTypes.number,
	amount: React.PropTypes.number
}
