import { combineReducers } from 'redux'
import date from './date'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'
import sheet from './sheet'

const todoSheetReducer = combineReducers({
  date,
  projects,
  operation,
  error,
  modals,
  sheet
})

export default todoSheetReducer
