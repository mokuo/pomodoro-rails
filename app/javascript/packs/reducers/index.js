import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'

const todosReducer = combineReducers({
  date,
  projects,
  operation
})

export default todosReducer
