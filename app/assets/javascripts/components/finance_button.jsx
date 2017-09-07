function FinanceButton(props){
	return(
		<div onClick={props.fetchFinances} className={'navigation__button'}>
			{props.name}
		</div>
	)
}

FinanceButton.propTypes = {
	name: React.PropTypes.string.isRequired,
	url: React.PropTypes.string.isRequired,
	fetchFinances: React.PropTypes.func.isRequired
}
