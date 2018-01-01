import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'

const todosReducer = combineReducers({
  date,
  projects
})

export default todosReducer
