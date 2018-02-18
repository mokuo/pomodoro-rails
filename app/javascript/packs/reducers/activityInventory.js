import { combineReducers } from 'redux'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'
import sheet from './sheet'

const activityInventoryReducer = combineReducers({
  projects,
  operation,
  error,
  modals,
  sheet
})

export default activityInventoryReducer
