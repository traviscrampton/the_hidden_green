function Income(props){
	return(
		<div className="itemContainer">
			<div className="account__name__type">
				<div className="account__name">
					{props.name}
				</div>
			</div>
			<div className="account__amount">
				{props.amount}
			</div>
		</div>
	)
}

Income.propTypes = {
	name: React.PropTypes.string,
	amount: React.PropTypes.number
}
