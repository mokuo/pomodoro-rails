import { connect } from 'react-redux'
import UnexpectedErrorAlert from '../components/UnexpectedErrorAlert'
import { closeUnexpectedError } from '../actions/unexpectedError'

const mapStateToProps = state => (
  {
    errorMessage: state.unexpectedError.errorMessage,
    isOpen: state.unexpectedError.isOpen
  }
)

const mapDispatchToProps = dispatch => (
  {
    onDismiss: () => {
      dispatch(closeUnexpectedError())
    }
  }
)

const UnexpectedErrorAlertContainer = connect(mapStateToProps, mapDispatchToProps)(UnexpectedErrorAlert)

export default UnexpectedErrorAlertContainer
