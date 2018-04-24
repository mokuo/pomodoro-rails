import React from 'react'
import DateNavigation from '../containers/DateNavigation'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import UnexpectedErrorAlertContainer from '../containers/UnexpectedErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const TodoSheet = () =>
  (
    <div>
      <ErrorAlertContainer />
      <UnexpectedErrorAlertContainer />
      <DateNavigation />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default TodoSheet
