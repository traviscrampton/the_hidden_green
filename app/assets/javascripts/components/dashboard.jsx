
var DashBoard = React.createClass({
	propTypes: {
		financeOptions: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string.isRequired,
			url: React.PropTypes.string.isRequired,
		})),
		activeFinances: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string,
			amount: React.PropTypes.number,
			minimum_monthly_payment: React.PropTypes.number,
			interest_rate: React.PropTypes.number
		})),
		activeFinance: React.PropTypes.string.isRequired
	},

	getInitialState: function(){
		return {
			financeOptions: this.props.financeOptions,
			activeFinance: this.props.activeFinance,
			activeFinances: this.props.activeFinances
		}
	},

	getFinances: function(index){
		this.setAllFinancesInActive()
		this.setActiveFinance(index)
	},

	setActiveFinance: function(index){
		var activeFinance = this.state.financeOptions[index]
		activeFinance.isActive = true
		this.fetchFinance(activeFinance)
	},

	fetchFinance: function(activeFinance) {
		$.ajax({
			url:activeFinance.url,
			type:'GET',
			context: this,
			success: function(activeFinances) {
				this.setFinances(activeFinance, activeFinances)
			},
			error: function(){
				console.log("There was an error processing whatever you were trying to do")
			}
		})
	},

	setFinances: function(activeFinance, activeFinances){
		this.state.activeFinance = activeFinance.name
		this.state.activeFinances = activeFinances
		this.setState(this.state)
	},

	setAllFinancesInActive: function(){
		var financeOptions = this.state.financeOptions
		for (i = 0; i < financeOptions.length; ++i){
			financeOptions[i].isActive = false
		}
	},

	render: function(){
		return(
			<div>
				<div className={"navigation__buttons"}>
					{this.state.financeOptions.map(function(finance, index){
						return <FinanceButton
							key={index}
							name={finance.name}
							url={finance.url}
							isActive={finance.isActive} fetchFinances={function(){this.getFinances(index)}.bind(this)} />
					}.bind(this))}
				</div>
				<div className="contentView">
					<ActiveFinanceView activeFinance={this.state.activeFinance} activeFinances={this.state.activeFinances}/>
				</div>
			</div>
		)
	}
})
