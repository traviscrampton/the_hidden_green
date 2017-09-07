
var DashBoard = React.createClass({
	propTypes: {
		financeOptions: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string.isRequired,
			url: React.PropTypes.string.isRequired,
			isActive: false
		}))
	},

	getInitialState: function(){
		return {
			financeOptions: this.props.financeOptions
		}
	},

	render: function(){
		return(
			<div className={"navigation__buttons"}>
				{this.state.financeOptions.map(function(finance, index){
					return <FinanceButton key={index} name={finance.name} url={finance.url} isActive={finance.isActive} />
				})}
			</div>
		)
	}
})
