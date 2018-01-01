import React from 'react'
import SelectableDateNavigation from '../containers/SelectableDateNavigation'
import Todos from '../containers/Todos'

const TodoApp = () =>
  (
    <div>
      <SelectableDateNavigation />
      <Todos />
    </div>
  )

export default TodoApp
