function AddFinance(props){
	return(
		<div className="itemContainer">
			<button>Add {props.financeType} Here</button>
		</div>
	)
}

AddFinance.PropTypes = {
	financeType: React.PropTypes.string.isRequired
}
