const initialState = {
  isOpen: false,
  errorMessage: '',
}

const unexpectedError = (state = initialState, action) => {
  switch (action.type) {
    case 'RECEIVE_UNEXPECTED_ERROR': {
      return {
        isOpen: true,
        errorMessage: action.errorMessage
      }
    }
    case 'CLOSE_UNEXPECTED_ERROR': {
      return initialState
    }
    default:
      return state
  }
}

export default unexpectedError
