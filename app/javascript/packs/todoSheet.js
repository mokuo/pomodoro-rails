import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import thunkMiddleware from 'redux-thunk'
import { createStore, applyMiddleware } from 'redux'
import axios from 'axios'
import todoSheetReducer from './reducers/todoSheet'
import TodoSheet from './components/TodoSheet'

const store = createStore(
  todoSheetReducer,
  applyMiddleware(thunkMiddleware)
)

axios.defaults.headers['X-CSRF-TOKEN'] = document.querySelector('meta[name = "csrf-token"]').content
axios.defaults.headers.Accept = 'application/json'
axios.defaults.headers['Content-Type'] = 'application/json'

render(
  <Provider store={store}>
    <TodoSheet />
  </Provider>,
  document.getElementById('todoSheet')
)
