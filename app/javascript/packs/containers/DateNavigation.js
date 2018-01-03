import { connect } from 'react-redux'
import addDays from 'date-fns/add_days'
import format from 'date-fns/format'
import Navigation from '../components/Navigation'
import { changeDate } from '../actions/date'
import { fetchTodos } from '../actions/todos'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const mapDispatchToProps = dispatch => {
  const shiftDate = day => {
    const date = document.getElementById('date').text
    const previousDate = addDays(date, day)
    const formattedDate = format(previousDate, 'YYYY-MM-DD')
    dispatch(changeDate(formattedDate))
    dispatch(fetchTodos(formattedDate))
  }

  return {
    onPreviousClick: () => {
      shiftDate(-1)
    },
    onNextClick: () => {
      shiftDate(1)
    }
  }
}

const DateNavigation = connect(
  mapStateToProps,
  mapDispatchToProps
)(Navigation)

export default DateNavigation
