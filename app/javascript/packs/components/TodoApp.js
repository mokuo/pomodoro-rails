import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import Todos from '../containers/Todos'
import ErrorAlert from '../containers/ErrorAlert'

const TodoApp = () =>
  (
    <div>
      <ErrorAlert />
      <DateNavigation />
      <Todos />
    </div>
  )

export default TodoApp
