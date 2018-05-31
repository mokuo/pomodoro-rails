import React from 'react'
import DateNavigationContainer from '../containers/DateNavigationContainer'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlert from '../containers/ErrorAlert'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const TodoSheet = () =>
  (
    <div>
      <ErrorAlert />
      <DateNavigationContainer />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default TodoSheet
