import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import thunkMiddleware from 'redux-thunk'
import { createStore, applyMiddleware } from 'redux'
import axios from 'axios'
import todosReducer from './reducers/index'
import TodoApp from './components/TodoApp'

const store = createStore(
  todosReducer,
  applyMiddleware(thunkMiddleware)
)

axios.defaults.headers['X-CSRF-TOKEN'] = document.querySelector('meta[name = "csrf-token"]').content
axios.defaults.headers.Accept = 'application/json'
axios.defaults.headers['Content-Type'] = 'application/json'

render(
  <Provider store={store}>
    <TodoApp />
  </Provider>,
  document.getElementById('todos')
)
