import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import todosReducer from './reducers/todos'
import Todos from './containers/Todos'

const store = createStore(todosReducer)

render(
  <Provider store={store}>
    <Todos />
  </Provider>,
  document.getElementById('todos')
)
