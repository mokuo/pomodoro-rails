import { connect } from 'react-redux'
import DateNavigation from '../components/DateNavigation'
import { previousDate, nextDate } from '../actions/date'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const mapDispatchToProps = dispatch => (
  {
    onPreviousClick: () => {
      dispatch(previousDate())
    },
    onNextClick: () => {
      dispatch(nextDate())
    }
  }
)

const SelectableDateNavigation = connect(
  mapStateToProps,
  mapDispatchToProps
)(DateNavigation)

export default SelectableDateNavigation
