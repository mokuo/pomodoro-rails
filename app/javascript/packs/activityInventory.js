import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import thunkMiddleware from 'redux-thunk'
import { createStore, applyMiddleware } from 'redux'
import axios from 'axios'
import activityInventoryReducer from './reducers/activityInventory'
import ActivityInventory from './components/ActivityInventory'

const store = createStore(
  activityInventoryReducer,
  applyMiddleware(thunkMiddleware)
)

axios.defaults.headers['X-CSRF-TOKEN'] = document.querySelector('meta[name = "csrf-token"]').content
axios.defaults.headers.Accept = 'application/json'
axios.defaults.headers['Content-Type'] = 'application/json'

render(
  <Provider store={store}>
    <ActivityInventory />
  </Provider>,
  document.getElementById('activityInventory')
)
