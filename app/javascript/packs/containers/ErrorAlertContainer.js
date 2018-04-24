import { connect } from 'react-redux'
import ErrorAlert from '../components/ErrorAlert'

const mapStateToProps = state => (
  {
    error: state.error.toJS()
  }
)

const ErrorAlertContainer = connect(mapStateToProps)(ErrorAlert)

export default ErrorAlertContainer
