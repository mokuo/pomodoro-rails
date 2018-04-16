import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const TodoSheet = () =>
  (
    <div>
      <ErrorAlertContainer />
      <DateNavigation />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default TodoSheet
