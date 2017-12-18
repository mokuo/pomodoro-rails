import { combineReducers } from 'redux'

function projects(state = window.projects, action) {
  return state
}

const todosReducer = combineReducers({
  projects
})

export default todosReducer
