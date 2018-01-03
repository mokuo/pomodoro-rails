import React from 'react'
import SelectableDateNavigation from '../containers/SelectableDateNavigation'
import Todos from '../containers/Todos'
import ErrorAlert from '../containers/ErrorAlert'

const TodoApp = () =>
  (
    <div>
      <ErrorAlert />
      <SelectableDateNavigation />
      <Todos />
    </div>
  )

export default TodoApp
