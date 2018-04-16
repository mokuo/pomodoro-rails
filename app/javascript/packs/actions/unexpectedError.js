export const receiveUnexpectedError = errorMessage => (
  {
    type: 'RECEIVE_UNEXPECTED_ERROR',
    errorMessage
  }
)

export const closeUnexpectedError = () => (
  {
    type: 'CLOSE_UNEXPECTED_ERROR'
  }
)
