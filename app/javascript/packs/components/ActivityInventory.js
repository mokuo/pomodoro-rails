import React from 'react'
import ProjectListContainer from '../containers/ProjectListContainer'
import ErrorAlertContainer from '../containers/ErrorAlertContainer'
import UnexpectedErrorAlertContainer from '../containers/UnexpectedErrorAlertContainer'
import DeleteTaskModal from '../containers/DeleteTaskModal'

const ActivityInventory = () =>
  (
    <div>
      <ErrorAlertContainer />
      <UnexpectedErrorAlertContainer />
      <ProjectListContainer />
      <DeleteTaskModal />
    </div>
  )

export default ActivityInventory
