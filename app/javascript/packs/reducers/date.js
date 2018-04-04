let initialState = null
if (location.pathname === '/todos') { initialState = window.date }

const date = (state = initialState, action) => {
  switch (action.type) {
    case 'CHANGE_DATE':
      return action.date
    default:
      return state
  }
}

export default date
