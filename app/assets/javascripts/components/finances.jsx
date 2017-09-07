function Finances(props){

	if(props.isBaseSetting){
		return(
			<center className='hidden__home'>
				<img src="hidden_green_icon.png" alt=""></img>
				<div className="hidden__get_started">THE HIDDEN GREEN</div>
			</center>
		)
	} else {
		return(
		<div>
			<div className="itemContainer">
				<button>Add Here</button>
			</div>
			<div>
				{props.activeFinances.map(function(viance, index){
						return <Finance
							key={viance.id}
							name={viance.name}
							amount={viance.amount}
							interestRate={viance.interest_rate} minimumMonthlyPayment={viance.minimum_monthly_payment}  />
				})}
			</div>
		</div>
	)
	}
}

Finances.propTypes = {
	isBaseSetting: React.PropTypes.bool.isRequired,
	activeFinances: React.PropTypes.arrayOf(React.PropTypes.shape({
		name: React.PropTypes.string,
		amount: React.PropTypes.number,
		minimum_monthly_payment: React.PropTypes.number,
		interest_rate: React.PropTypes.number
	}))
}
