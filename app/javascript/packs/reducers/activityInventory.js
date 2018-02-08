import { combineReducers } from 'redux'
import projects from './projects'
import operation from './operation'
import error from './error'
import modals from './modals'

const activityInventoryReducer = combineReducers({
  projects,
  operation,
  error,
  modals
})

export default activityInventoryReducer
