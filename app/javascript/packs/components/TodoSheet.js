import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlert from '../containers/ErrorAlert'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const TodoSheet = () =>
  (
    <div>
      <ErrorAlert />
      <DateNavigation />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default TodoSheet
