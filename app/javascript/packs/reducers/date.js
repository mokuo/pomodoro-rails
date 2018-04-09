const date = (state = window.date, action) => {
  switch (action.type) {
    case 'CHANGE_DATE':
      return action.date
    default:
      return state
  }
}

export default date
