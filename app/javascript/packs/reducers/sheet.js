const sheet = () => {
  switch (location.pathname) {
    case '/todos':
      return 'todo'
    case '/activities':
      return 'activity'
    default:
      return null
  }
}

export default sheet
