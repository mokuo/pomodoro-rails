import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'

const todosReducer = combineReducers({
  date,
  projects,
  operation,
  error,
  modals
})

export default todosReducer
