import { connect } from 'react-redux'
import DatePicker from '../components/DatePicker'

const mapStateToProps = state => (
  {
    date: state.date
  }
)

const DateChanger = connect(mapStateToProps)(DatePicker)

export default DateChanger
