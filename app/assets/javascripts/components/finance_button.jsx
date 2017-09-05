function FinanceButton(props){
	return(
		<div>
			{props.name}
		</div>
	)
}

FinanceButton.propTypes = {
	name: React.PropTypes.string.isRequired,
	url: React.PropTypes.string.isRequired
}
