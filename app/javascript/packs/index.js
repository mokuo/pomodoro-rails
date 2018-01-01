import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import thunkMiddleware from 'redux-thunk'
import { createStore, applyMiddleware } from 'redux'
import todosReducer from './reducers/index'
import TodoApp from './components/TodoApp'

const store = createStore(
  todosReducer,
  applyMiddleware(thunkMiddleware)
)

render(
  <Provider store={store}>
    <TodoApp />
  </Provider>,
  document.getElementById('todos')
)
