import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'
import error from './error'

const todosReducer = combineReducers({
  date,
  projects,
  operation,
  error
})

export default todosReducer
