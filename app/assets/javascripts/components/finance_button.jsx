function FinanceButton(props){
	return(
		<div onClick={props.fetchFinances} className={this.isActiveButton(props)}>
			{props.name}
		</div>
	)
}

function isActiveButton(props){
	var classNames = "navigation__button "
	if(props.isActive) {classNames += "selected__navigation__button"}
	return classNames
}

FinanceButton.propTypes = {
	name: React.PropTypes.string.isRequired,
	url: React.PropTypes.string.isRequired,
	fetchFinances: React.PropTypes.func.isRequired
}
