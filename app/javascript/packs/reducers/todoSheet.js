import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'
import sheet from './sheet'
import unexpectedError from './unexpectedError'

const todoSheetReducer = combineReducers({
  date,
  projects,
  operation,
  error,
  modals,
  sheet,
  unexpectedError
})

export default todoSheetReducer
