import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import Todos from '../containers/Todos'
import ErrorAlert from '../containers/ErrorAlert'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const TodoApp = () =>
  (
    <div>
      <ErrorAlert />
      <DateNavigation />
      <Todos />
      <DeleteTaskModal />
    </div>
  )

export default TodoApp
