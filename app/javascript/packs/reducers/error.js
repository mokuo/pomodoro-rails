const initialState = {
  code: 0,
  messages: []
}

const error = (state = initialState, action) => {
  switch (action.type) {
    case 'RECEIVE_ERROR': {
      if (action.error.code === 0) {
        return initialState
      }
      return action.error
    }
    default:
      return state
  }
}

export default error
