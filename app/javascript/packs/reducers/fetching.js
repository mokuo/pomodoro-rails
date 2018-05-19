const fetching = (state = false, action) => {
  switch (action.type) {
    case 'START_FETCHING':
      return true
    case 'FINISH_FETCHING':
      return false
    default:
      return state
  }
}

export default fetching
