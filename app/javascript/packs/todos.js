import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import todosReducer from './reducers/todos'
import TodoApp from './components/TodoApp'

const store = createStore(todosReducer)

console.log(store.getState());

render(
  <Provider store={store}>
    <TodoApp />
  </Provider>,
  document.getElementById('todos')
)
