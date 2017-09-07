function FinanceButton(props){
	return(
		<div className={'navigation__button'}>
			{props.name}
		</div>
	)
}

FinanceButton.propTypes = {
	name: React.PropTypes.string.isRequired,
	url: React.PropTypes.string.isRequired,
	isActive: React.PropTypes.bool.isRequired
}
