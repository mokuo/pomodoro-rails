import { combineReducers } from 'redux'

function date(state = window.date, action) {
  return state
}

function projects(state = window.projects, action) {
  return state
}

const todosReducer = combineReducers({
  date,
  projects
})

export default todosReducer
