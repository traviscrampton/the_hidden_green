
var DashBoard = React.createClass({
	propTypes: {
		financeOptions: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string.isRequired,
			url: React.PropTypes.string.isRequired,
			isActive: React.PropTypes.bool.isRequired
		})),
		baseSetting: React.PropTypes.bool.isRequired,
		activeFinances: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string,
			amount: React.PropTypes.number,
			minimum_monthly_payment: React.PropTypes.number,
			interest_rate: React.PropTypes.number
		}))
	},

	getInitialState: function(){
		return {
			financeOptions: this.props.financeOptions,
			baseSetting: this.props.baseSetting,
			activeFinances: this.props.activeFinances
		}
	},

	getFinances: function(index){
		this.setAllFinancesInActive()
		this.setActiveFinance(index)
	},

	setActiveFinance: function(index){
		var activeFinance = this.state.financeOptions[index]
		this.fetchFinance(activeFinance)
		activeFinance.isActive = true
		this.setState(this.state)
	},

	fetchFinance: function(activeFinance) {
		$.ajax({
			url:activeFinance.url,
			type:'GET',
			context: this,
			success: function(response) {
				this.setFinances(response)
			},
			error: function(){
				console.log("There was an error processing whatever you were trying to do")
			}
		})
	},

	setFinances: function(finances){
		this.state.baseSetting = false
		this.state.activeFinances = finances
		this.setState(this.state)
	},

	setAllFinancesInActive: function(){
		var financeOptions = this.state.financeOptions
		for (i = 0; i < financeOptions.length; ++i){
			financeOptions[i].isActive = false
		}
		this.setState(this.state)
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
					<Finances isBaseSetting={this.state.baseSetting} activeFinances={this.state.activeFinances}/>
				</div>
			</div>
		)
	}
})
