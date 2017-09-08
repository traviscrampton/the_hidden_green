function Accounts(props){
	return(
		<div>
			<AddFinance financeType="Account" />
			<div>
				{props.accountsCollection.map(function(account, index){
						return <Account
							key={account.id}
							name={account.name}
							amount={account.amount}
							interestRate={account.interest_rate} />
				})}
			</div>
		</div>
	)
}

Accounts.PropTypes = {
	accountsCollection: React.PropTypes.arrayOf(React.PropTypes.shape({
		name: React.PropTypes.string.isRequired,
		amount: React.PropTypes.number.isRequired,
		interest_rate: React.PropTypes.number.isRequired
	}))
}
