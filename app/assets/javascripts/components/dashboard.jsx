
var DashBoard = React.createClass({
	propTypes: {
		financeOptions: React.PropTypes.arrayOf(React.PropTypes.shape({
			name: React.PropTypes.string.isRequired,
			url: React.PropTypes.string.isRequired
		}))
	},

	render: function(){
		return(
			<div>
				{this.props.financeOptions.map(function(finance, index){
					return <FinanceButton key={index} name={finance.name} url={finance.url} />
				})}
			</div>
		)
	}
})
