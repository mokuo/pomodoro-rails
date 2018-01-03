import { connect } from 'react-redux'
import Alert from '../components/Alert'

const mapStateToProps = state => (
  {
    error: state.error
  }
)

const ErrorAlert = connect(mapStateToProps)(Alert)

export default ErrorAlert
