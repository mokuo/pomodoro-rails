import { connect } from 'react-redux'
import DateNavigation from '../components/DateNavigation'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const DateNavigationContainer = connect(mapStateToProps)(DateNavigation)

export default DateNavigationContainer
