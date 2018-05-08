import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'
import sheet from './sheet'
import unexpectedError from './unexpectedError'
import fetching from './fetching'

const todoSheetReducer = combineReducers({
  date,
  projects,
  operation,
  error,
  modals,
  sheet,
  unexpectedError,
  fetching
})

export default todoSheetReducer
