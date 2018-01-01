const projects = (state = window.projects, action) => {
  switch (action.type) {
    case 'RECEIVE_TODOS':
      return action.projects
    default:
      return state
  }
}

export default projects
