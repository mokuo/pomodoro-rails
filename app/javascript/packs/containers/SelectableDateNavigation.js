import { connect } from 'react-redux'
import addDays from 'date-fns/add_days'
import format from 'date-fns/format'
import DateNavigation from '../components/DateNavigation'
import { changeDate } from '../actions/date'
import { fetchTodos } from '../actions/todos'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const mapDispatchToProps = dispatch => (
  {
    onPreviousClick: () => {
      const date = document.getElementById('date').text
      const previousDate = addDays(date, -1)
      const formattedDate = format(previousDate, 'YYYY-MM-DD')
      dispatch(changeDate(formattedDate))
      dispatch(fetchTodos(formattedDate))
    },
    onNextClick: () => {
      const date = document.getElementById('date').text
      const previousDate = addDays(date, 1)
      const formattedDate = format(previousDate, 'YYYY-MM-DD')
      dispatch(changeDate(formattedDate))
      dispatch(fetchTodos(formattedDate))
    }
  }
)

const SelectableDateNavigation = connect(
  mapStateToProps,
  mapDispatchToProps
)(DateNavigation)

export default SelectableDateNavigation
