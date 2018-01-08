import { connect } from 'react-redux'
import Alert from '../components/Alert'

const mapStateToProps = state => (
  {
    error: state.error.toJS()
  }
)

const ErrorAlert = connect(mapStateToProps)(Alert)

export default ErrorAlert
